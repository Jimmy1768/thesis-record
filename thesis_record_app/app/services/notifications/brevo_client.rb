require "json"
require "net/http"
require "socket"

module Notifications
  class BrevoClient
    BASE_URI = URI("https://api.brevo.com/v3/smtp/email")
    DEFAULT_OPEN_TIMEOUT = 3
    DEFAULT_READ_TIMEOUT = 5

    def initialize(api_key: ENV["BREVO_API_KEY"])
      @api_key = api_key
      raise "Missing BREVO_API_KEY" if @api_key.blank?
    end

    def send_email(to:, subject:, html:, sender_name:, sender_email:)
      payload = {
        sender: { name: sender_name, email: sender_email },
        to: normalize_recipients(to),
        subject: subject,
        htmlContent: html
      }

      response = force_ipv4? ? post_ipv4(payload) : post(BASE_URI, payload)
      response.code.to_i == 201
    rescue Net::OpenTimeout, Net::ReadTimeout, Errno::ETIMEDOUT, SocketError => error
      Rails.logger.error("[Brevo] delivery failed: #{error.class}: #{error.message}")
      false
    end

    private

    attr_reader :api_key

    def normalize_recipients(to)
      case to
      when String
        [ { email: to, name: to } ]
      when Hash
        [ to ]
      when Array
        to.map { |recipient| recipient.is_a?(String) ? { email: recipient, name: recipient } : recipient }
      else
        raise ArgumentError, "unsupported recipient type: #{to.class}"
      end
    end

    def post(uri, payload)
      Net::HTTP.start(uri.host, uri.port, use_ssl: true, open_timeout: open_timeout, read_timeout: read_timeout) do |http|
        http.request(request_for(uri, payload))
      end
    end

    def post_ipv4(payload)
      host = BASE_URI.host
      ipv4 = Addrinfo.getaddrinfo(host, nil, :INET).first&.ip_address
      raise "No IPv4 found for #{host}" unless ipv4

      Net::HTTP.start(host, BASE_URI.port, ipaddr: ipv4, use_ssl: true, open_timeout: open_timeout, read_timeout: read_timeout) do |http|
        http.request(request_for(BASE_URI, payload))
      end
    end

    def request_for(uri, payload)
      Net::HTTP::Post.new(uri).tap do |request|
        request["api-key"] = api_key
        request["Content-Type"] = "application/json"
        request["accept"] = "application/json"
        request.body = payload.to_json
      end
    end

    def force_ipv4?
      ActiveModel::Type::Boolean.new.cast(ENV["BREVO_FORCE_IPV4"])
    end

    def open_timeout
      ENV.fetch("BREVO_OPEN_TIMEOUT", DEFAULT_OPEN_TIMEOUT).to_f
    end

    def read_timeout
      ENV.fetch("BREVO_READ_TIMEOUT", DEFAULT_READ_TIMEOUT).to_f
    end
  end
end

class SourceHealthController < ApplicationController
  before_action :require_research_operator

  def show
    @summary = PublicSources::SourceHealthSummary.call
  end
end

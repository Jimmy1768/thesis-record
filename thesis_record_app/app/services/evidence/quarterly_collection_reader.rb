module Evidence
  class QuarterlyCollectionReader
    def self.find!(quarter:, revision:)
      raise ArgumentError, "quarter is invalid" unless quarter.match?(/\A\d{4}-Q[1-4]\z/)
      raise ArgumentError, "revision must be positive" unless Integer(revision).positive?

      QuarterlyCollection.includes(:periodic_captures, :quarterly_result_set)
                         .find_by!(quarter: quarter, revision: revision, status: "completed")
    end
  end
end

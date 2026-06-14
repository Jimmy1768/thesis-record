class BfsQualityReviewsController < ApplicationController
  before_action :require_research_operator

  def show
    @summary = PublicSources::Bfs::QualityReviewSummary.call
  end
end

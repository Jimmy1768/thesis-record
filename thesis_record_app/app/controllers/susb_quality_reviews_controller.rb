class SusbQualityReviewsController < ApplicationController
  before_action :require_research_operator

  def show
    @summary = PublicSources::Susb::QualityReviewSummary.call
  end
end

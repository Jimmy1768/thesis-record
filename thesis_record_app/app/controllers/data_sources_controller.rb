class DataSourcesController < ApplicationController
  before_action :require_research_operator
  before_action :set_data_source, only: %i[show edit update]

  def index
    @data_sources = DataSource.order(updated_at: :desc, name: :asc)
  end

  def show
    @intake_manifests = @data_source.intake_manifests.order(updated_at: :desc, name: :asc)
  end

  def new
    @data_source = DataSource.new(default_data_source_attributes)
  end

  def create
    @data_source = DataSources::Create.call!(attributes: data_source_params, actor: current_user)
    redirect_to @data_source, notice: "Data source registered"
  rescue ActiveRecord::RecordInvalid => error
    @data_source = error.record.is_a?(DataSource) ? error.record : DataSource.new(data_source_params)
    render :new, status: :unprocessable_entity
  end

  def edit
  end

  def update
    DataSources::Update.call!(data_source: @data_source, attributes: data_source_params, actor: current_user)
    redirect_to @data_source, notice: "Data source updated"
  rescue ActiveRecord::RecordInvalid
    render :edit, status: :unprocessable_entity
  end

  private

  def set_data_source
    @data_source = DataSource.find(params[:id])
  end

  def data_source_params
    params.require(:data_source).permit(
      :name, :source_kind, :source_status, :storage_zone, :privacy_classification,
      :retention_rule, :claim_status_allowed, :public_repo_allowed,
      :structured_private_allowed, :private_file_storage_allowed, :secret_material_present,
      :redaction_required, :minimum_cell_rule_required, :human_review_required
    )
  end

  def default_data_source_attributes
    {
      source_status: "source_registered",
      storage_zone: "production_postgresql",
      privacy_classification: "internal",
      retention_rule: "retain_until_reviewed",
      claim_status_allowed: "not_evidence",
      public_repo_allowed: false,
      structured_private_allowed: true,
      private_file_storage_allowed: false,
      secret_material_present: false,
      redaction_required: true,
      minimum_cell_rule_required: true,
      human_review_required: true
    }
  end
end

class IntakeManifestsController < ApplicationController
  before_action :require_research_operator
  before_action :set_data_source
  before_action :set_intake_manifest, only: %i[show edit update]

  def index
    @intake_manifests = @data_source.intake_manifests.order(updated_at: :desc, name: :asc)
  end

  def show
  end

  def new
    @intake_manifest = @data_source.intake_manifests.new(default_intake_manifest_attributes)
  end

  def create
    @intake_manifest = IntakeManifests::Create.call!(
      data_source: @data_source,
      attributes: intake_manifest_params,
      actor: current_user
    )
    redirect_to [ @data_source, @intake_manifest ], notice: "Intake manifest created"
  rescue ActiveRecord::RecordInvalid => error
    @intake_manifest = error.record.is_a?(IntakeManifest) ? error.record : @data_source.intake_manifests.new(intake_manifest_params)
    render :new, status: :unprocessable_entity
  end

  def edit
  end

  def update
    IntakeManifests::Update.call!(
      intake_manifest: @intake_manifest,
      attributes: intake_manifest_params,
      actor: current_user
    )
    redirect_to [ @data_source, @intake_manifest ], notice: "Intake manifest updated"
  rescue ActiveRecord::RecordInvalid
    render :edit, status: :unprocessable_entity
  end

  private

  def set_data_source
    @data_source = DataSource.find(params[:data_source_id])
  end

  def set_intake_manifest
    @intake_manifest = @data_source.intake_manifests.find(params[:id])
  end

  def intake_manifest_params
    params.require(:intake_manifest).permit(
      :name, :manifest_status, :storage_zone, :privacy_classification,
      :retention_rule, :public_repo_allowed, :structured_private_allowed,
      :private_file_storage_allowed, :secret_material_present, :redaction_required,
      :minimum_cell_rule_required, :human_review_required
    )
  end

  def default_intake_manifest_attributes
    {
      manifest_status: "empty_manifest",
      storage_zone: @data_source.storage_zone,
      privacy_classification: @data_source.privacy_classification,
      retention_rule: @data_source.retention_rule,
      public_repo_allowed: false,
      structured_private_allowed: true,
      private_file_storage_allowed: @data_source.private_file_storage_allowed,
      secret_material_present: false,
      redaction_required: true,
      minimum_cell_rule_required: true,
      human_review_required: true
    }
  end
end

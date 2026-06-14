class CreateMetricQualityReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :metric_quality_reviews do |t|
      t.references :metric_observation, null: false, foreign_key: true
      t.references :data_source, foreign_key: true
      t.string :policy_version, null: false
      t.string :source_metric_status, null: false
      t.string :review_status, null: false
      t.string :review_reason_code, null: false
      t.string :reviewed_by, null: false
      t.datetime :reviewed_at, null: false
      t.jsonb :review_metadata, null: false, default: {}

      t.timestamps
    end

    add_index :metric_quality_reviews, :review_status
    add_index :metric_quality_reviews, :policy_version
    add_index :metric_quality_reviews, :reviewed_at
    add_index :metric_quality_reviews,
              :metric_observation_id,
              unique: true,
              name: "index_metric_quality_reviews_on_observation"
  end
end

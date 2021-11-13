# frozen_string_literal: true

class JobListingRecord < ApplicationRecord
  self.table_name = "job_listings"

  include PgSearch::Model
  pg_search_scope :search,
                  against: { title: "A", description: "B" },
                  using: {
                    tsearch: {
                      dictionary: "english",
                      tsvector_column: "searchable",
                      prefix: true,
                    },
                  }

  belongs_to :employer, class_name: "EmployerRecord"
end

class JobListing < ApplicationRecord
  include PgSearch::Model
  belongs_to :employer

  pg_search_scope :search,
                  against: { title: "A", description: "B" },
                  using: {
                    tsearch: {
                      dictionary: "english",
                      tsvector_column: "searchable",
                      prefix: true,
                    },
                  }
end

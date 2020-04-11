json.extract! job_listing, :id, :title, :description, :location, :salary, :created_at, :updated_at
json.url job_listing_url(job_listing, format: :json)

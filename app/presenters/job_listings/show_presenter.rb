module JobListings
  class ShowPresenter
    delegate :contact_url, :contact_email, :employer_name, :location, :title, :salary, to: :job_listing

    attr_reader :job_listing

    private

    def initialize(job_listing:)
      @job_listing = job_listing
    end

    public

    def avatar_url
      "/images/logo#{(1..6).to_a.shuffle.first}.jpeg"
    end

    def has_contact_url?
      contact_url.present?
    end

    def description
      MarkdownConverter.markdown(job_listing.description)
    end
  end
end

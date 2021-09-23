# frozen_string_literal: true

class PaginationNavBuilder
  include Pagy::Frontend

  private

  attr_reader :paginator, :request

  def initialize(paginator:, request:)
    @paginator = paginator
    @request = request
  end

  public

  def build
    pagy_bootstrap_nav(paginator)
  end
end

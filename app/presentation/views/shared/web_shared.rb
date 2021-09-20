# frozen_string_literal: true

# Included in any View that is used for the web app
module Shared
  module WebShared
    include ActionView::Helpers::TagHelper
    include LayoutShared
  end
end
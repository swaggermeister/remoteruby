# frozen_string_literal: true

module Shared
  # Functions used by the layout
  module LayoutShared
    def self.included(_klass)
      attr_reader :current_employer
    end

    def toast_flashes(flash:)
      flash.reject do |(type, _message)|
        # to avoid extra "true" flash message from devise
        # showing under the expected timeout flash
        type.to_s == "timedout"
      end
    end

    # https://picturepan2.github.io/spectre/components/toasts.html#toasts
    def flash_toast_class(flash_type:)
      toast_style = case flash_type
        when "notice"
          "toast-success"
        when "alert", "timedout"
          "toast-error"
        else
          raise "No toast class defined for #{flash_type}"
        end

      "toast #{toast_style}"
    end

    def employer_avatar_url(employer)
      AvatarUrlBuilder.build(employer: employer)
    end

    def current_year
      Date.current.year
    end

    def layout_columns_class
      "column col-xl-6 col-lg-10 col-md-8 col-sm-10 col-xs-12 col-mx-auto col-4"
    end

    def blog_url
      "https://www.blog.remoterubyonrails.com"
    end
  end
end

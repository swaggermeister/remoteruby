# frozen_string_literal: true

module Shared
  # Functions used by the layout
  module LayoutShared
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
  end
end

# frozen_string_literal: true

module FlashHelper
  # https://picturepan2.github.io/spectre/components/toasts.html#toasts
  def toast_class(flash_type:)
    toast_style = case flash_type
                  when 'notice'
                    'toast-success'
                  when 'alert', 'timedout'
                    'toast-error'
                  else
                    raise "No toast class defined for #{flash_type}"
                  end

    "toast #{toast_style}"
  end
end

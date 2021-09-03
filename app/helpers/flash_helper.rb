module FlashHelper
  # https://picturepan2.github.io/spectre/components/toasts.html#toasts
  def toast_class(flash_type:)
    "toast " + case flash_type
    when "notice"
      "toast-success"
    when "alert"
      "toast-error"
    when "timedout"
      "toast-error"
    else
      raise "No toast class defined for #{flash_type}"
    end
  end
end

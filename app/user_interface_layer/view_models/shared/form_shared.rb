# frozen_string_literal: true

module Shared
  module FormShared
    include ActionView::Helpers::TagHelper

    def errors_hint_tag(form, attr_val)
      if (errors = errors_for(form, attr_val)).blank?
        return nil
      end

      tag.div("#{attr_val.to_s.humanize} #{errors}", class: "form-input-hint")
    end

    def errors_hint_tag_no_field_name(form, attr_val)
      if (errors = errors_for(form, attr_val)).blank?
        return nil
      end

      tag.div(errors, class: "form-input-hint")
    end

    def form_group(view_context, form, attr_val, &block)
      content = view_context.capture(&block)
      tag.div(content, class: "form-group #{form_group_error_class(form, attr_val)}")
    end

    private

    def form_group_error_class(form, attr_val)
      if errors_for(form, attr_val).present?
        "has-error"
      else
        ""
      end
    end

    def errors_for(form, attr_val)
      messages = form.object.errors[attr_val]
      messages.join(", ")
    end
  end
end

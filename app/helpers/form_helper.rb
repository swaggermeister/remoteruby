# frozen_string_literal: true

module FormHelper
  def errors_hint_tag(form, attr)
    if (errors = errors_for(form, attr)).blank?
      return nil
    end

    tag.p("#{attr.to_s.upcase_first} #{errors}", class: 'form-input-hint')
  end

  def errors_hint_tag_no_field_name(form, attr)
    if (errors = errors_for(form, attr)).blank?
      return nil
    end

    tag.p(errors, class: 'form-input-hint')
  end

  def form_group(form, attr)
    tag.div(yield, class: "form-group #{form_group_error_class(form, attr)}")
  end

  private

  def form_group_error_class(form, attr)
    if errors_for(form, attr).present?
      'has-error'
    else
      ''
    end
  end

  def errors_for(form, attr)
    messages = form.object.errors[attr]
    messages.join(', ')
  end
end

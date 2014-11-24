#
# Custom FormBuilder with support for showing inline field validation errors
# close to related fields.
#
class FormWithValidations < ActionView::Helpers::FormBuilder
  # Currently we generate error messages only for text and password form fields.
  helpers_to_define = %w(text_field password_field text_area)

  def error_messages(options={})
    super options.reverse_merge(:message => nil)
  end

  helpers_to_define.each do |name|
    # Define the method for the helper
    define_method(name) do |field, *args|
      options = args.last.is_a?(Hash) ? args.pop : {}

      # If the field's value is blank and a default value is given, use that
      if (default_value = options.delete(:default_value))
        if self.object.send(field).blank? && (options[:value].blank? || (options[:value] == default_value))
          (options[:style] ||= "") << ";color:#888";
          options[:value] ||= default_value
        end
        options[:onclick] ||= "clearDefaultText(this, '#{default_value}');"
        options[:onblur] ||= "setDefaultText(this, '#{default_value}');"
        options[:onfocus] ||= "clearDefaultText(this, '#{default_value}');"
      end

      if options.delete(:required)
        (options[:class] ||= "") << " required_field";
      end

      # Set onblur event handlers for form fields
      #
      # Eg. For the field email_confirmation, add the handler
      # onblur="validateEmailConfirmation()"
      #
      if options.delete(:validate)
        blur_code = options[:onblur] || ""
        blur_code += "validate#{field.to_s.camelize}()"
        options[:onblur] += blur_code
      end

      if options.delete(:pick_from_override) && self.object
        self.object[field] = self.object.send(field)
      end

      record_errors = self.object ? self.object.field_error_messages : Hash.new

      field_id = options[:id] || "#{object_name}_#{field}"

      # Convert field ids of nested resources like
      # user[professional_profile]_about_me to
      # user_professional_profile_about_me by replacing [ and ] with _
      #
      field_id.gsub!(/[\[\]]/, '_')
      field_id.gsub!(/_+/, '_')

      # Generate a div tag for displaying the field's error.
      error_field = @template.content_tag('div',
        record_errors[field],
        :id => "#{field_id}_error",
        :class => 'inline_error')

      # Append the constructed error field to the form field (returned by
      # super()) and return that as the response.
      full_content = super(field, options) + error_field
      return full_content unless record_errors[field]
      @template.content_tag(:div, full_content, :class => 'error_field_box')
    end
  end
end


class ActiveRecord::Base
  # Constructs and returns Hash of error messages mapped to model attribute
  # names, suitable for displaying as form validation errors.
  #
  def field_error_messages
    record_errors = Hash.new

    # Construct map from each field name to corresponding human readable error
    # message.
    self.errors.each do |attr, error_msg|
      #
      # Replace _'s with ' 's (spaces) in field names so that the error message
      # for a field like email_confirmation says 'Email confirmation ....'
      #
      field_error_msg = self.class.human_attribute_name(attr) + ' ' + error_msg
      record_errors[attr.to_sym] = field_error_msg
    end

    return record_errors
  end
end
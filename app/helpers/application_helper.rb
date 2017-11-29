# frozen_string_literal: true

module ApplicationHelper
  ALERT_TYPES = %i[success info warning danger] unless const_defined?(:ALERT_TYPES)

  def full_title(page_title = '')
    base_title = 'Fox on Rails'
    page_title.empty? ? base_title : (page_title + ' | ' + base_title)
  end

  def bootstrap_flash(options = {})
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger  if type == :alert
      type = :danger  if type == :error
      next unless ALERT_TYPES.include?(type)

      tag_class = options.extract!(:class)[:class]
      tag_options = {
        class: "alert fade in alert-#{type} #{tag_class} col-xs-12 col-sm-8 col-sm-offset-2"
      }.merge(options)

      close_button = content_tag(:button, raw('&times;'), type: 'button', class: 'close', 'data-dismiss' => 'alert')

      Array(message).each do |msg|
        text = content_tag(:div, close_button + msg, tag_options)
        flash_messages << text if msg
      end
    end
    flash_messages.join('\n').html_safe
  end

  def online_status(user)
    content_tag :span, user.name, class: "user-#{user.id} online_status #{'online' if user.online?}"
  end
end

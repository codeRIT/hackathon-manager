module HackathonManagerHelper
  def title(page_title)
    content_for(:page_title) { page_title }
    content_for(:title) { page_title }
    page_title
  end

  def btn_link_to(name, path, options = {})
    options[:class] ? options[:class] += " button" : options[:class] = "button"
    link_to(name, path, options)
  end

  def phone_link_to(phone_number)
    link_to(phone_number, "tel:#{phone_number}")
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       no_intra_emphasis: true,
                                       fenced_code_blocks: true,
                                       disable_indented_code_blocks: true,
                                       autolink: true,
                                       tables: true,
                                       underline: true,
                                       hard_wrap: true)
    markdown.render(text).html_safe
  end

  def bold(value)
    "<strong>#{h(value)}</strong>".html_safe
  end

  # Same as link_to, but adds a special active class whenever the link matches
  # the current page.
  # Only  https://github.com/rails/rails/blob/master/actionview/lib/action_view/helpers/url_helper.rb
  def active_link_to(name = nil, options = nil, html_options = nil, &block)
    # this is from Rails source - ignore rubocop
    # rubocop:disable Style/ParallelAssignment
    html_options, options, name = options, name, block if block_given?
    options ||= {}
    # rubocop:enable Style/ParallelAssignment

    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(options)
    html_options["href".freeze] ||= url

    # Begin custom
    active_children = html_options.delete('active_children')
    active_children = true if active_children.nil?
    current_url = request.env['PATH_INFO']
    if current_page?(url) || (active_children && current_url.include?(url))
      active_class = html_options.delete('active_class') || 'active'
      existing_class = html_options['class'] || ''
      html_options['class'] = existing_class + ' ' + active_class
    end
    # End custom

    content_tag("a".freeze, name || url, html_options, &block)
  end

  # https://github.com/rails/sprockets-rails/issues/298#issuecomment-168927471
  def asset_available?(logical_path)
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include? logical_path
    else
      Rails.application.assets_manifest.assets[logical_path].present?
    end
  end

  def collection_or_text(model_value, collection)
    model_value.blank? || collection.include?(model_value) ? collection : nil
  end

  def acc_status_class(acc_status)
    case acc_status
    when "denied"
      "danger"
    when "accepted"
      "success"
    when "waitlist"
      "info"
    when "late_waitlist"
      "secondary"
    when "pending"
      "secondary"
    when "rsvp_denied"
      "danger"
    when "rsvp_confirmed"
      "success"
    end
  end

  def display_datetime(datetime, opts = {})
    formatted = ""
    if Time.now - datetime < 5.hours
      formatted << "#{time_ago_in_words(datetime, include_seconds: true)} ago"
    else
      format = datetime.year == Time.now.year ? "%b %-d <small>at %I:%M %P</small>" : "%b %-d, %Y <small>at %I:%M %P</small>"
      if Time.now - datetime > 6.months
        format = "%b %-d, %Y"
      end
      formatted << "on " if opts[:in_sentence]
      formatted << datetime.strftime(format)
    end
    "<span title=\"#{datetime}\">#{formatted}</span>".html_safe
  end

  def google_maps_link(*args)
    query = args.reject(&:blank?).join('+')
    query = CGI.escape(query)
    "https://www.google.com/maps/search/?api=1&query=#{query}"
  end
end

module HackathonManagerHelper
  def title(page_title)
    content_for(:page_title) { page_title }
    content_for(:title) { page_title + " – #{Rails.configuration.hackathon['name']}" }
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

  # Same as link_to, but adds a special active class whenever the link matches
  # the current page.
  # Only  https://github.com/rails/rails/blob/master/actionview/lib/action_view/helpers/url_helper.rb
  def active_link_to(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}

    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(options)
    html_options["href".freeze] ||= url

    # Begin custom
    if current_page?(url)
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
end

class Agreement < ApplicationRecord
  include ActionView::Helpers::UrlHelper
  validates_presence_of :name
  validates_presence_of :agreement

  strip_attributes

  has_and_belongs_to_many :questionnaires

  def formatted_agreement
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

    markdown.render(agreement).html_safe
  end
end

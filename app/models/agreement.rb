class Agreement < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:name], using: { tsearch: { prefix: true } }
  include ActionView::Helpers::UrlHelper
  validates_presence_of :name
  validates_presence_of :agreement

  strip_attributes

  has_and_belongs_to_many :questionnaires

  def self.ransackable_attributes(_)
    ["created_at", "id", "name", "updated_at"]
  end

  def formatted_agreement
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render(agreement).gsub("<a href=", "<a target=\“_blank\” rel=\"noreferrer noopener\" href=").html_safe
  end
end

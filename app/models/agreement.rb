class Agreement < ApplicationRecord
  include ActionView::Helpers::UrlHelper
  validates_presence_of :name
  validates_presence_of :agreement_url

  strip_attributes

  has_and_belongs_to_many :questionnaires

  def formatted_agreement
    "<p>I read and accept the&nbsp;#{link_to name, agreement_url, target: '_blank'}&nbsp;agreement.</p>".html_safe
  end
end

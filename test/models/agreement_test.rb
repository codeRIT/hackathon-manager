require 'test_helper'

class AgreementTest < ActiveSupport::TestCase
  should have_and_belong_to_many :questionnaires

  should strip_attribute :name
  should strip_attribute :agreement

  should validate_presence_of :name
  should validate_presence_of :agreement

  should "not allow questionnaires to accept agreements for others" do
    @questionnaire1 = create(:questionnaire)
    @agreement = create(:agreement)
    @questionnaire2 = create(:questionnaire, agreements: Agreement.all)

    assert_equal false, @questionnaire1.all_agreements_accepted?
    assert_equal true, @questionnaire2.all_agreements_accepted?
  end
end

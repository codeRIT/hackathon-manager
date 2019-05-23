require "test_helper"

class MessageTemplateTest < ActiveSupport::TestCase
  should validate_presence_of :html

  should "return correct value for customized?" do
    message = create(:message_template)
    assert_equal false, message.customized?
    Timecop.freeze(1.minute.from_now) do
      message.update_attribute(:html, "foo")
    end
    assert_equal true, message.reload.customized?
  end

  should "refresh stored instance when calling #load_singleton" do
    # Mutate the in-memory instance
    MessageTemplate.instance.html = "foo"
    assert_equal "foo", MessageTemplate.instance.html
    MessageTemplate.load_singleton
    # Mutation no longer exists
    assert_not_equal "foo", MessageTemplate.instance.html
  end

  should "refresh singleton after instance has aged" do
    # Mutate the in-memory instance
    MessageTemplate.instance.html = "foo"
    assert_equal "foo", MessageTemplate.instance.html
    Timecop.freeze(1.minute.from_now) do
      # Mutation no longer exists
      assert_not_equal "foo", MessageTemplate.instance.html
    end
  end

  should "load default template at #load_singleton" do
    MessageTemplate.destroy_all
    assert_equal 0, ActiveRecord::Base.connection.execute("select count(*) from message_templates").first[0]
    MessageTemplate.load_singleton
    assert_not_nil MessageTemplate.uncached_instance
    assert_equal 1, MessageTemplate.count
  end

  should "return first record for #uncached_instance" do
    MessageTemplate.destroy_all
    create(:message_template, html: "this is it")
    assert_equal "this is it", MessageTemplate.uncached_instance.html
  end

  should "update template with default when calling #replace_with_default" do
    MessageTemplate.destroy_all
    create(:message_template, html: "custom body")
    assert_equal "custom body", MessageTemplate.uncached_instance.html
    MessageTemplate.replace_with_default
    assert_not_equal "custom body", MessageTemplate.uncached_instance.html
  end
end

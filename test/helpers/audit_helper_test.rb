require "test_helper"

class AuditHelperTest < ActiveSupport::TestCase
  include AuditHelper

  context "display_audit_value" do
    should "show (none) for empty values" do
      assert_equal "(none)", display_audit_value(nil, "foo")
      assert_equal "(none)", display_audit_value("", "foo")
      assert_equal "(none)", display_audit_value([], "foo")
    end

    should "use human name for acc_status" do
      assert_equal "RSVP Confirmed", display_audit_value("rsvp_confirmed", "acc_status")
    end

    should "model values for related fields" do
      bus_list = create(:bus_list, name: "Foo bus list")
      assert_equal "Foo bus list", display_audit_value(bus_list.id, "bus_list_id")
      user = create(:user, email: "abc@example.com")
      assert_equal "abc@example.com", display_audit_value(user.id, "checked_in_by_id")
    end

    should "use human description for arrays" do
      assert_equal "foo, bar, baz", display_audit_value(["foo", "bar", "baz"], "foo")
    end

    should "default to regular value" do
      assert_equal "Hello world", display_audit_value("Hello world", "foo")
    end
  end
end

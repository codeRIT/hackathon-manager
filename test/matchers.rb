module HackathonManager
  module Shoulda
    module Matchers
      # Ensures that the given instance or class has an attachment with the
      # given name.
      #
      # Example:
      #   describe User do
      #     it { should have_attached_file(:avatar) }
      #   end
      def have_attached_file name
        HaveAttachedFileMatcher.new(name)
      end

      class HaveAttachedFileMatcher
        def initialize attachment_name
          @attachment_name = attachment_name
        end

        def matches? subject
          @subject = subject
          responds?
        end

        def failure_message
          "Should have an attachment named #{@attachment_name}"
        end

        def failure_message_when_negated
          "Should not have an attachment named #{@attachment_name}"
        end
        alias negative_failure_message failure_message_when_negated

        def description
          "have an attachment named #{@attachment_name}"
        end

        protected

        def responds?
          file = @subject.send(@attachment_name)
          file.respond_to?(:attached?) && file.respond_to?(:attach)
        end
      end
    end
  end
end
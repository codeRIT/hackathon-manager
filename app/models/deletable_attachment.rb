# This needs to be included after all has_attached_file statements in a class
module DeletableAttachment
  extend ActiveSupport::Concern

  class_methods do
    def deletable_attachment(name, dependent: :purge_later)
      attr_accessor :"delete_#{name}"

      before_validation { send(name)&.purge if send("delete_#{name}") == '1' }

      define_method :"delete_#{name}=" do |value|
        instance_variable_set :"@delete_#{name}", value
      end
    end
  end
end

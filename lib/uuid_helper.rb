require 'rubygems'
require 'uuidtools'

module UUIDHelper
  def self.included(base)
    base.instance_eval do
      include InstanceMethods
      attr_readonly :id
      before_create :set_uuid
    end
  end
  
  module InstanceMethods
    private
      def set_uuid
        self.id = UUIDTools::UUID.timestamp_create().to_s
      end
    end
end
  
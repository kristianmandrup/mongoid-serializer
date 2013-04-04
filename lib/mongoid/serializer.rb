require "mongoid/serializer/version"

module Mongoid
  module Serializer
    def self.configure!
      Mongoid::Document.send(:include, ActiveModel::SerializerSupport)
      Mongoid::Criteria.delegate(:active_model_serializer, to: :to_a)
    end

    def self.enable_state_tracking!
      require "mongoid/serializer/state_tracking"
    end
  end
end

if defined?(Mongoid)
  Mongoid::Serializer.configure!
end

module ActiveModel
  class MongoidSerializer < Serializer
    def id
      object._id
    end 

    def status
      return 204 if object.respond_to?(:destroyed?) && object.destroyed?
      return 201 if object.respond_to?(:created?) && object.created?      
    end
  end
end

module ActiveModel::StateTracking
  extend ActiveSupport::Concern

  included do
    after_create do
      @created = true
    end

    after_update do
      @created = false
    end

    after_destroy do
      @destroyed = true
    end
  end

  def created?
    @created == true
  end

  def destroyed?
    @destroyed == true
  end
end
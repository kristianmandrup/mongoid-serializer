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

module JsonStatusCodeRender
  def render(*args)
    obj = args.first
    if no_status? obj
      if resource_was_destroyed? obj
        # 204 : request was received and understood, but no need to send any data back
        args.first[:status] = 204
      elsif resource_was_created? obj
        # 201 Created: The request has been fulfilled and resulted in a new resource
        args.first[:status] = 201
      end      
    end

    super
  end

  protected

  def resource_was_destroyed? obj
    obj[:json].respond_to?(:destroyed?) && obj[:json].destroyed?
  end

  def resource_was_created? obj
    obj[:json].respond_to?(:created?) && obj[:json].created?
  end

  def no_status? obj
    obj.key?(:json) && obj[:json].kind_of?(Mongoid::Document) && !obj.key?(:status)
  end  
end
require "mongoid/serializer/version"

module Mongoid
  module Serializer
    def self.configure!
      Mongoid::Document.send(:include, ActiveModel::SerializerSupport)
      Mongoid::Criteria.delegate(:active_model_serializer, to: :to_a)
    end
  end
end


module ActiveModel
  class StatusSerializer < Serializer
    def http_status
      return 204 if object.respond_to?(:destroyed?) && object.destroyed?
      return 201 if object.respond_to?(:created?) && object.created?      
    end
  end
end

module ActiveModel
  class MongoidSerializer < StatusSerializer
    def id
      object._id
    end
  end
end

if defined?(Mongoid)
  Mongoid::Serializer.configure!
end
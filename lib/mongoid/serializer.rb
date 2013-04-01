require "mongoid/serializer/version"

module Mongoid
  module Serializer
    def self.configure!
      Mongoid::Document.send(:include, ActiveModel::SerializerSupport)
      Mongoid::Criteria.delegate(:active_model_serializer, to: :to_a)
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

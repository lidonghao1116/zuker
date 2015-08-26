module Imageable
  extend ActiveSupport::Concern

  included do 
    has_many :attachments, as: :imageable
  end

  module ClassMethods
    
  end 
end
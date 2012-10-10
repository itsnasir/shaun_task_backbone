class Message < ActiveRecord::Base
  attr_accessible :content
  class << self
    def find_or_create_default

      return Message.all if count > 0
      (0..8).each {Message.create }
      Message.all

    end
  end
end

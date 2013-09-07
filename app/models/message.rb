class Message < ActiveRecord::Base
  attr_accessible :content, :conversation_id, :sender_id, :recipient_id

  belongs_to :conversation
end

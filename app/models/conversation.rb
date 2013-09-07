class Conversation < ActiveRecord::Base
   attr_accessible :user_id, :second_user_id

   belongs_to :user
   has_many :messsages
end

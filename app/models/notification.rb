class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :team, optional: true
  belongs_to :comment, optional: true
  belongs_to :room, optional: true
  belongs_to :chat, optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  ACTION_VALUES = ["favorite", "follow", "comment", "chat"]
  validates :action,  presence: true, inclusion: {in:ACTION_VALUES}
  validates :checked, inclusion: {in: [true,false]}
end
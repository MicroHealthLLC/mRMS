class ChannelOrder < ApplicationRecord
  belongs_to :user
  belongs_to :channel, optional: true
  include ActAsPosition

  before_create :set_default_position
  after_save :update_position
  after_destroy :remove_position

  default_scope -> {where(user_id: User.current.id).order('position ASC')}


  def set_default_position
    if position.nil? or position.zero?
      self.position = self.class.pluck(:position).compact.count + 1
    end
  end

end

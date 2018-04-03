
module ActAsPosition

  private

  def update_position
   if position_changed?
      if position_was.nil?
        insert_position
      else
        shift_positions
      end
    end
  end

  def insert_position
    self.class.where("position >= ? AND id <> ?", position, id).update_all("position = position + 1")
  end

  def remove_position
    self.class.where("position >= ? AND id <> ?", position_was, id).update_all("position = position - 1")
  end

  def shift_positions
    offset = position_was <=> position
    min, max = [position, position_was].sort
    r = self.class.where("id <> ? AND position BETWEEN ? AND ?", id, min, max).update_all("position = position + #{offset}")
    if r != max - min
      reset_positions_in_list
    end
  end

  def reset_positions_in_list
    position_scope.reorder(:position, :id).pluck(:id).each_with_index do |record_id, p|
      self.class.where(:id => record_id).update_all(:position => p+1)
    end
  end
end

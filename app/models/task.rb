class Task < ActiveRecord::Base

  def due_soon?
    if self.due
      true if self.due <= (Date.today + 7)
    else
      nil
    end
  end
end

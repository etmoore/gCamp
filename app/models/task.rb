class Task < ActiveRecord::Base

  validates :description, presence: true

  def due_soon?
    if self.due
      true if self.due <= (Date.today + 7)
    else
      nil
    end
  end
end

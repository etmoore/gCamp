class Task < ActiveRecord::Base

  validates :description, presence: true
  validate :not_past_due

  belongs_to :project
  has_many :comments

  def not_past_due
    if self.due.present? && past_due_date?
      errors.add(:due, 'date has already passed')
    end
  end

  def due_soon?
    self.due.present? && self.due <= (Date.today + 7)
  end

  private

    def past_due_date?
      self.due < Date.today
    end

end

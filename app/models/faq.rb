class Faq

  # FIXTHIS keeps track of all instances ever created, will result in duplicate faqs
  def self.all
    ObjectSpace.each_object(self).to_a
  end

  attr_accessor :question, :answer

  def initialize(question, answer)
    self.question = question
    self.answer = answer

  end

end

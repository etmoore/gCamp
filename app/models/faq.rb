class Faq

  @@all_faqs = []
  # FIXTHIS keeps track of all instances ever created, will result in duplicate faqs
  def self.all
    @@all_faqs
  end

  attr_accessor :question, :answer

  def initialize(question, answer)
    self.question = question
    self.answer = answer
    @@all_faqs << self
  end

end

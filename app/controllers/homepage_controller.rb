class HomepageController < ApplicationController

  def show

    @columns = {Tasks:['Grouped by projects and lists, just the way you like\'em'],
                Documents:['Upload','Comment','Revise'],
                Comments:['Comment on task and documents','Get email notifications']
                }

    @quote1 = Quote.new("Your time is limited, so don't waste it living someone else's life.", "Steve Jobs")
    @quote2 = Quote.new("Whatever you are, be a good one.", "Abraham Lincoln")
    @quote3 = Quote.new("Wisdom begins in wonder.", "Socrates")
    @quote4 = Quote.new("Blessed are those who give without remembering and take without forgetting.", "Elizbeth Bibesco")
    @quote5 = Quote.new("Have nothing in your house that you do not know to be useful or believe to be beautiful", "William Morris")
    @quote6 = Quote.new("Happiness is not found in things you possess, but in what you have the courage to release.", "Nathanial Hawthorne")
    @quote7 = Quote.new("Three things in human life are important. The first is to be kind. The second is to be kind. And the third is to be kind.", "Henry James")
    @quote8 = Quote.new("I am certain of nothing but the holiness of the heart's affections and the truth of the imagination.", "John Keats")
    @quote9 = Quote.new("Self-knowledge is no guarantee of happiness, but it is on the side of happiness and can supply the courage to fight for it.", "Simone de Beauvoir")
    @quote10 = Quote.new("The soul should always stand ajar, ready to welcome the ecstatic experience.", "Emily Dickinson")
    @quote11 = Quote.new("With freedom, books, flowers, and the moon, who could not be happy?", "Oscar Wilde")

    @quotes_and_authors = [@quote1, @quote2, @quote3, @quote4, @quote5, @quote6, @quote7, @quote8, @quote9, @quote10, @quote11]
  end

end

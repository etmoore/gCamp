class HomepageController < ApplicationController

  def show
    @columns = {Tasks:['Grouped by projects and lists, just the way you like\'em'],
                Documents:['Upload','Comment','Revise'],
                Comments:['Comment on task and documents','Get email notifications']
                }
    @quotes_and_authors = [["Your time is limited, so don't waste it living someone else's life.", "Steve Jobs"],
                            ["Whatever you are, be a good one.", "Abraham Lincoln"],
                            ["Wisdom begins in wonder.", "Socrates"],
                            ["Blessed are those who give without remembering and take without forgetting.", "Elizbeth Bibesco"],
                            ["Have nothing in your house that you do not know to be useful or believe to be beautiful", "William Morris"],
                            ["Happiness is not found in things you possess, but in what you have the courage to release.", "Nathanial Hawthorne"],
                            ["Three things in human life are important. The first is to be kind. The second is to be kind. And the third is to be kind.", "Henry James"],
                            ["I am certain of nothing but the holiness of the heart's affections and the truth of the imagination.", "John Keats"],
                            ["Self-knowledge is no guarantee of happiness, but it is on the side of happiness and can supply the courage to fight for it.", "Simone de Beauvoir"],
                            ["The soul should always stand ajar, ready to welcome the ecstatic experience.", "Emily Dickinson"],
                            ["With freedom, books, flowers, and the moon, who could not be happy?", "Oscar Wilde"]]
  end

end

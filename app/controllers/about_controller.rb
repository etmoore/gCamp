class AboutController < MarketingController

  def show
    @projects = Project.all
    @tasks = Task.all
    @memberships = Membership.all
    @users = User.all
    @comments = Comment.all
  end

end

module ObjectCreationMethods

  def new_project(overrides = {})
    defaults = {name: Faker::Company.name}
    Project.new(defaults.merge(overrides))
  end

  def create_project(overrides = {})
    new_project(overrides).tap(&:save!)
  end

  def new_user(overrides = {})
    defaults = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      password: "password",
      email: Faker::Internet.email,
    }
    User.new(defaults.merge(overrides))
  end

  def create_user(overrides = {})
    new_user(overrides).tap(&:save!)
  end

  def create_membership(overrides = {})
    defaults = {
      user: new_user,
      project: new_project,
      role: "Member"
    }
    Membership.create!(defaults.merge(overrides))
  end
end

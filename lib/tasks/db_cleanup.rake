namespace :db do
  desc "Deletes invalid memberships and comments"
  task clean_up: :environment do
    Membership.where.not(user_id: User.pluck(:id)).destroy_all
    Comment.where.not(task_id: Task.pluck(:id)).destroy_all
  end
end

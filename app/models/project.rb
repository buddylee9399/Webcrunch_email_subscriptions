# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Project < ApplicationRecord
  belongs_to :user

  has_many :project_users
  has_many :users, through: :project_users

  has_many :tasks, dependent: :destroy

  def author(user)
    self.project_users.where(user: user)
  end
end

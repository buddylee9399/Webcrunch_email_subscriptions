# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  email                        :string           default(""), not null
#  encrypted_password           :string           default(""), not null
#  first_name                   :string
#  last_name                    :string
#  notify_when_added_to_project :boolean          default(TRUE)
#  notify_when_task_completed   :boolean          default(TRUE)
#  notify_when_task_created     :boolean          default(TRUE)
#  remember_created_at          :datetime
#  reset_password_sent_at       :datetime
#  reset_password_token         :string
#  unsubscribe_hash             :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  before_create :add_unsubscribe_hash
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects

  has_many :project_users
  has_many :projects, through: :project_users

  after_create :assign_default_role
  def assign_default_role
    if User.count == 1
      self.add_role(:site_admin) if self.roles.blank?
      self.add_role(:admin)
      self.add_role(:customer)      
    else
      self.add_role(:customer) if self.roles.blank?
    end
  end  
  private

    def add_unsubscribe_hash
      self.unsubscribe_hash = SecureRandom.hex
    end  
end

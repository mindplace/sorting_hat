# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  email        :string           not null
#  house_choice :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class User < ApplicationRecord
  has_many :quizzes

  validates :name, :email, presence: true
  validates :email, uniqueness: { message: 'Someone with this email address has already submitted their quiz, was it you?' }
end

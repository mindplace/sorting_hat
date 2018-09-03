# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string           not null
#  gryffindor  :integer          not null
#  ravenclaw   :integer          not null
#  hufflepuff  :integer          not null
#  slytherin   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          not null
#

class Answer < ApplicationRecord
  belongs_to :question
end

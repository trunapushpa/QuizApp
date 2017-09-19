class Subgenre < ApplicationRecord
  belongs_to :genre
  has_many :questions
  has_many :quiztakens
  has_many :users, :through => :quiztakens
end

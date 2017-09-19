class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :recoverable,
  devise :database_authenticatable, :registerable,
          :rememberable, :trackable, :validatable
  # devise :omniauthable, :omniauth_providers => [:facebook]
  has_many :quiztakens
  has_many :subgenres, :through => :quiztakens
end

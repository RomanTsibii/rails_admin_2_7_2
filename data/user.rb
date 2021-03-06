class User < ApplicationRecord
  include Passpartu

  has_many :comments, as: :commentable, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {
    member: 1,
    admin: 10
  }
end

class User < ApplicationRecord
  has_many :financial_groups, dependent: :destroy
  has_many :financial_entities, foreign_key: 'author_id', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :email, :password, presence: true
end

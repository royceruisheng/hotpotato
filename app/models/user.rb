class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one_attached :photo

  has_and_belongs_to_many :workflows#, class_name: "Workflows", foreign_key: "creator_id"
  has_many :task_members, dependent: :destroy
  has_many :tasks, through: :task_members
  has_many :item_members, dependent: :destroy
  has_many :items, through: :item_members
end

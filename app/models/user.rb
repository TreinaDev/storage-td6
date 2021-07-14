class User < ApplicationRecord
  validates :name, :role, :registration_code, :cpf, presence: true
  validates :cpf, :registration_code, uniqueness: true
  validates :cpf, numericality: { only_integer: true }
  validates :cpf, length: { is: 11 }
  validates :cpf, cpf: true

  enum role: [:user, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

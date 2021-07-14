class User < ApplicationRecord
  belongs_to :warehouse, optional: true

  validates :name, :role, :registration_code, :cpf, presence: true
  validates :warehouse, presence: true, if: :user?
  validates :cpf, :registration_code, uniqueness: true
  validates :cpf, numericality: { only_integer: true }
  validates :cpf, length: { is: 11 }
  validates :cpf, cpf: true
  validate :domain_check

  enum role: [:user, :admin]

  private
  def domain_check
    return unless email
    errors.add(:email, 'domínio não permitido') unless email.end_with?('@mercadores.com.br')
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

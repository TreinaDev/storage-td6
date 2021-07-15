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
  before_validation :set_default_password

  private
  def domain_check
    return unless email
    errors.add(:email, I18n.t('users.domain_not_allowed')) unless email.end_with?('@mercadores.com.br')
  end

  def set_default_password
    self.password = cpf
    self.password_confirmation = cpf
  end

  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_initialize :set_defaut_role, if: :new_record?

  before_validation :add_user_to_company

  belongs_to :shipping_company, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[company admin]

  def set_defaut_role
    self.role ||= :company
  end

  def add_user_to_company
    return if admin?

    email_domain = email.split('@')[1]
    company = ShippingCompany.where(email_domain: email_domain)
    if company.any?
      self.shipping_company_id = company[0].id
    else
      errors.add(:email, 'não atrelado a empresas cadastradas no sistema, favor entrar em contato com a Administração.') 
    end
  end
end

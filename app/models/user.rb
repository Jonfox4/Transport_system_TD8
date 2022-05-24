class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:company, :admin]
  after_initialize :set_defaut_role, :if => :new_record?
  def set_defaut_role
    self.role ||= :company
  end
end

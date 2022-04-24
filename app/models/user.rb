class User < ApplicationRecord
  enum role: [ :client, :admin ]
  after_initialize :set_default_role, :if => :new_record?

  has_many :admin_notifications, class_name: 'Notification', foreign_key: 'admin_id', dependent: :destroy
  has_many :client_notifications, class_name: 'Notification', foreign_key: 'client_id', dependent: :destroy

  validates :email, presence: true, uniqueness: true

  def set_default_role
    self.role ||= :client
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_token_authenticatable
end

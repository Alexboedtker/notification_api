class User < ApplicationRecord
  enum role: [ :client, :admin ]

  has_many :admin_notifications, class_name: 'Notification', foreign_key: 'admin_id', dependent: :destroy
  has_many :client_notifications, class_name: 'Notification', foreign_key: 'client_id', dependent: :destroy

  validates :email, presence: true, uniqueness: true

  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_token_authenticatable

  def set_default_role
    self.role ||= :client
  end
end

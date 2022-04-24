class Notification < ApplicationRecord
  belongs_to :admin, class_name: 'User'
  belongs_to :client, class_name: 'User'
end

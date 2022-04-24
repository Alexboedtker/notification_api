class Api::V1::NotificationsController < Api::V1::BaseController
  def index
    #@notifications = current_user.client_notifications
    @notifications = policy_scope(Notification) #check the policy if it's showing the correct notifications lewagon video
  end
end

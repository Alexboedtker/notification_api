class Api::V1::NotificationsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: [ :index, :show, :create ], fallback: :exception
  before_action :require_authentication!, only: [ :index, :show, :create ]
  before_action :set_notification, only: [ :show, :update ]

  def index
    @notifications = policy_scope(Notification) #check the policy if it's showing the correct notifications lewagon video
  end

  def create
    @notification = Notification.new(notification_params)
    @notification.admin = current_user
    authorize @notification
    if @notification.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def require_authentication!
    throw(:warden, scope: :user) unless current_user.presence
  end

  def set_notification
    @notification = Notification.find(params[:id])
    authorize @notification  # For Pundit
  end

  def notification_params
    params.require(:notification).permit(:date, :title, :description, :client_id)
  end

  def render_error
    render json: { errors: @notification.errors.full_messages },
      status: :unprocessable_entity
  end
end

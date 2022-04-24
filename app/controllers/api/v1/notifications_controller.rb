class Api::V1::NotificationsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: [ :index, :show, :create ], fallback: :exception

  def index
    @notifications = policy_scope(Notification)
  end

  def show
    @notification = Notification.find(params[:id])
    authorize @notification
  end

  def create
    @notification = Notification.new(notification_params)
    @notification.admin = current_user
    authorize @notification
    if @notification.save
      render :index, status: :created
    else
      render_error
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:date, :title, :description, :client_id)
  end

  def render_error
    render json: { errors: @notification.errors.full_messages },
      status: :unprocessable_entity
  end
end

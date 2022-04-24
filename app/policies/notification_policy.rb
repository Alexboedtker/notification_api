class NotificationPolicy < ApplicationPolicy
  def index?
    user.admin? || user.client?
  end

  def create?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.client?
        scope.where(notifications: { client_id: user.id })
      else
        scope.all
      end
    end
  end
end

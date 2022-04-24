class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.client?
        scope.where(notifications: { client_id: user.id })
      else
        scope.all
      end
    end

    def index?
      user.admin? || user.client?
    end

    def show?
      user.admin? || user.client?
    end

    def create?
      user.admin?
    end
  end
end

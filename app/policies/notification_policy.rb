class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # if user.client?
      #   scope.where(notifications: { client_id: user.id })
      # else
      #   scope.all
      # end
    scope.all
    end
  end
end

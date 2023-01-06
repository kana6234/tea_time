class Public::NotificationsController < ApplicationController
  def show
    notifications = current_user.passive_notifications.all
    notifications.update(is_checked: true)
    @notifications = notifications.where.not(visitor_id: current_user.id)
  end
end

class Public::NotificationsController < Public::BaseController
  def show
    notifications = current_user.passive_notifications.all
    notifications.update(is_checked: true)
    @notifications = notifications.recent.page(params[:page]).where.not(visitor_id: current_user.id)
  end
end

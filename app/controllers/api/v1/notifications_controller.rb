class Api::V1::NotificationsController < ApplicationController
  def user_notifications
    user = User.find_by(id: params[:id])

    if user
      notifications = Notification.where(teacher_id: user.id).order(created_at: :desc)
      render json: notifications.as_json(
        include: {
          assignment: { only: [:id, :name] },
          teacher: { only: [:id, :name, :email] }
        },
        except: [:updated_at]
      )
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
end

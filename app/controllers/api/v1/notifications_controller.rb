class Api::V1::NotificationsController < ApplicationController
  def user_notifications
  #   user = User.find_by(id: params[:id])

  #   if user
  #     notifications = Notification.where(teacher_id: user.id).order(created_at: :desc)
  #     render json: notifications.as_json(
  #       include: {
  #         assignment: { only: [:id, :name] },
  #         teacher: { only: [:id, :name, :email] }
  #       },
  #       except: [:updated_at]
  #     )
  #   else
  #     render json: { error: "User not found" }, status: :not_found
  #   end
  end

  def index
    user = User.find_by(id: params[:id])
    if user
      if user.role.name.eql?(STUDENT)
        classroom = user.classroom
        assignment_ids = Assignment.where(subject_id: classroom.subjects.ids).ids
        messages = Notification .where(assignment_id: assignment_ids, user_id: nil).order(created_at: :desc).limit(params[:limit]).pluck(:message, :created_at)
      else
        assignment_ids = Assignment.where(teacher_id: user.id).ids
        messages = Notification.where(assignment_id: assignment_ids, teacher_id: nil).order(created_at: :desc).limit(params[:limit]).pluck(:message, :created_at)
      end

      formatted_messages = messages.map do |msg, time|
        { message: msg, created_at: time }
      end

      render json: formatted_messages
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
end

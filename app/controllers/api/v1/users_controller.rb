class Api::V1::UsersController < ApplicationController
  def register
    user = User.new(user_params)
    user.status = 'pending'

    if user.save
      render json: { message: "User registered successfully. Once the request is approved, you can log in.", user: user }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def pending_approvals
    users = User.where(role_id: get_role_id(params[:type]), status: :pending)
    render json: { users: users.select(:id, :name, :status, :mobile_number) }, status: :ok
  end

  def approve
    user = User.find(params[:id])

    if user.update(status: :approved)
      UserMailer.approval_email(user).deliver_now
      render json: { message: "User approved and email sent" }, status: :ok
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def reject
    user = User.find(params[:id])

    if user.update(status: :rejected)
      UserMailer.rejection_email(user).deliver_now
      render json: { message: "User rejected and email sent" }, status: :ok
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    render json: UserBlueprint.render(User.all), status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :mobile_number, :status, :date_of_birth, :role_id, :classroom_id)
  end

  def get_role_id(type)
    Role.find_by(name: type)&.id
  end
end

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
    if params[:type].eql?(STUDENT)
      teacher = User.find_by(id: params[:teacher_id])
      users = User.where(role_id: get_role_id(params[:type]), classroom_id: teacher&.classroom_id, status: :pending)
    else
      users = User.where(role_id: get_role_id(params[:type]), status: :pending)
    end

    render json: { users: UserBlueprint.render_as_hash(users) }, status: :ok
  end

  def approved_users
    if params[:type].eql?(TEACHER)
      teacher = User.find_by(id: params[:teacher_id])
      users = User.where(role_id: get_role_id(params[:type]), classroom_id: teacher&.classroom_id, status: :approved)
    else
      users = User.where(role_id: get_role_id(params[:type]), status: :approved)
    end

    render json: { users: UserBlueprint.render_as_hash(users) }, status: :ok
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
    render json: { users: UserBlueprint.render_as_hash(User.all) }, status: :ok
  end

  def admin_dashboard_count
    render json: { pending_approvals_count: User.where(status: :pending, role_id: Role.where(name: [TEACHER, COMPANY]).select(:id)).count, classroom_count: Classroom.count }, status: :ok
  end

  def teacher_dashboard_count
    teacher_id = params[:id]
    teacher = User.find_by(id: teacher_id)
    classroom_id = teacher.classroom_id
    role_id = Role.find_by name: STUDENT
    render json: { subject_count: Subject.where(teacher_id:).count, student_count: User.where(classroom_id:, role_id:).count, assignment_count: Assignment.where(teacher_id:).count, pending_approval_count: User.where(classroom_id:, role_id:, status: :pending).count }
  end

  def show
    user = User.find_by id: params[:id]
    if user
      render json: { user: UserBlueprint.render_as_hash(user) }, status: :ok
    else
      render json: { error: 'Invalid user id, user not found' }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :mobile_number, :status, :date_of_birth, :role_id, :classroom_id)
  end

  def get_role_id(type)
    Role.find_by(name: type)&.id
  end
end

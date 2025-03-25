class Api::V1::RolesController < ApplicationController
  def index
    roles = Role.where.not(name: ADMIN).select(:id, :name)
    render json: roles, status: :ok
  end
end

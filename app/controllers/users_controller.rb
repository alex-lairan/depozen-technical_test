class UsersController < ApplicationController
  def index
    users = UsersRepository.new.all
    render json: users
  end
end

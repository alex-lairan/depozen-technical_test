class MyContractsController < ApplicationController
  def index
    contracts = ContractsRepository.new.contracts_of_user(params[:username])
    render json: contracts
  end
end

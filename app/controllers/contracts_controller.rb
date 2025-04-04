class ContractsController < ApplicationController
  def index
    contracts = ContractsRepository.new.all
    render json: contracts
  end
end

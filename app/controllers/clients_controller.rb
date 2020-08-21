class ClientsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :show]
  
  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client
    else
      render :new
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  private

  def client_params
    params.require(:client).permit(:name, :cpf, :email)
  end
end
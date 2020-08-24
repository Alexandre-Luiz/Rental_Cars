class ClientsController < ApplicationController
  before_action :authenticate_user!, only:[:index, :new, :create, :show]
  
  def index
    @clients = Client.all
  end

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

  def search
    @clients = Client.where('name like ?', "%#{params[:q]}")
  end

  private

  def client_params
    params.require(:client).permit(:name, :cpf, :email)
  end
end
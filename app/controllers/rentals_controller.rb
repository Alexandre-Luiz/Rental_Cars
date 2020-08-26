class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
    @clients = Client.all
    @car_categories = CarCategory.all
  end

  def create
    @rental = Rental.new(rental_params)
    # Veja que meu model rental tem um campo obrigatório que é o usuário
    # Como ele não veio do form, ele está em branco.
    # Para preenche-lo basta utilizar o método do devise e agora todos
    # atributos do meu model rental estão preenchidos
    @rental.user = current_user
    @rental.save
    redirect_to @rental, notice: 'Agendamento realizado com sucesso'
  end

  def search
    #@rentals = Rental.where(token: params[:q])
    @rentals = Rental.where('token LIKE UPPER(?)', "%#{params[:q]}%")
    render :index
  end

  private

  def rental_params
    # Atenção! Veja que o user_id não está vindo pelo params (form), 
    # mas sim do devise, por isso ele não está permitido aqui.
    params.require(:rental)
          .permit(:start_date, :end_date, :car_category_id, :client_id)
  end
end
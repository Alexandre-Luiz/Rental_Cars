class CarCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
  def index
    @car_categories = CarCategory.all
  end

  def show
    @car_category = CarCategory.find(params[:id])
  end

  # new é um get que traz um formulário - 
  # Não confundir com o post que é o envio
  def new
    @car_category = CarCategory.new
  end
  
  # Aqui sim tem-se um POST, ou seja, a submissão do form
  # É comum criar já com o permissionamento do que pode ser enviado para minha DB
  def create
    @car_category = CarCategory.new(car_category_params)
    if @car_category.save
      # Redireciono para o show do objeto que criei acima
      # Toda vez que eu executar algo que não for um get, preciso redirecionar para algum lugar
      # Refatorando
        #redirect_to car_category_path(id: @car_category.id)
      redirect_to @car_category
    else
      #redirect_to new_car_category_path
      render :new
    end
  end

  # action edit da o get no formulário de edição
  def edit
    @car_category = CarCategory.find(params[:id])
  end

  # action update envia as alterações feitas no edit
  def update
    @car_category = CarCategory.find(params[:id])
    if @car_category.update(car_category_params)
      redirect_to @car_category
    else
      render :edit
    end
  end

  def destroy
    @car_category = CarCategory.find(params[:id])
    @car_category.destroy
    #redirecionando para a index
    redirect_to car_categories_path
  end
private

  def car_category_params
    params.require(:car_category)
          .permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end
end
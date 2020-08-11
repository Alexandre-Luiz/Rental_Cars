class CarCategoriesController < ApplicationController
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
    #puts '======='
    #puts params
    #puts '======='
    @car_category = CarCategory.create(params
                      .require(:car_category)
                      .permit(:name, :daily_rate, :car_insurance, :third_party_insurance))
    
    # Redireciono para o show do objeto que criei acima
    redirect_to car_category_path(id: @car_category.id)
  end
end
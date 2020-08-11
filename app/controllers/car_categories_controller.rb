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
    @car_category = CarCategory.create(car_category_params)
    
    # Redireciono para o show do objeto que criei acima
    # Toda vez que eu executar algo que não for um get, preciso redirecionar para algum lugar
    # Refatorando
      #redirect_to car_category_path(id: @car_category.id)
    redirect_to @car_category
  end

  private
  def car_category_params
    params.require(:car_category)
          .permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end
end
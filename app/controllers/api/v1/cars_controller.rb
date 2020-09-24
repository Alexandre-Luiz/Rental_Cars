  class Api::V1::CarsController < ActionController::API

    def index
      # Incluindo os atributos do car_model e do car_category dentro do JSON do meu car.
      # Se eu não dou include, ele manda apenas o id
      render json: Car.available
                      .as_json(include: {car_model: { include: :car_category } }, 
                      except: :car_model_id), status: :ok
    end
  
    def show
      @car = Car.find(params[:id])
      render json: @car if @car
      
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: 'Carro não encontrado'
    end

    def create
      @car = Car.new(car_params)
      @car.save!
      render json: @car, status: :created
        
    rescue ActiveRecord::RecordInvalid
      render json: @car.errors.full_messages, status: :unprocessable_entity
    rescue ActionController::ParameterMissing
      render json: 'Parâmetros inválidos', status: :precondition_failed
    end

    def destroy
      @car = Car.find(params[:id])
      @car.destroy!
      render json: 'Registro excluído com sucesso', status: :ok

    rescue ActiveRecord::RecordNotFound
      render json: 'Registro não encontrado', status: :not_found
    end

    private

    def car_params
      params.require(:car).permit(:license_plate, :color, :mileage, :car_model_id)
    end

    # Definindo um novo padrão para o as_json que inclui por padrão o car_model
    #def as_json(options = {})
      #super(options.merge(include: :car_model))
    #end
  end


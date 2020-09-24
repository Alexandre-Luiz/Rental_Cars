require 'rails_helper'

describe 'Car management' do
  context 'index' do
    it 'renders available cars' do
      car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100,
                                        third_party_insurance: 100)
      car_model = CarModel.create!(name: 'Onix 1.0', year: 2019, manufacturer: 'Chevrolet',
                                  fuel_type: 'Flex', motorization: '1.0',
                                  car_category: car_category)
      Car.create!(license_plate: 'ABC1234', color: 'Vermelho', mileage: 0,
                  car_model: car_model, status: :available)
      Car.create!(license_plate: 'CBV1234', color: 'Preto', mileage: 1000,
                  car_model: car_model, status: :rented)

      # ----------- Como ficaria com FactoryBot ----------
      #car = Factory.create(:car, license_plate: 'ABC1234', status: :available)
      #Factory.create(:car, license_plate: 'CBV1234', status: :rented, car_model: car.car_model)
      # -------------------------------
      
      get '/api/v1/cars'
      #api_v1_cars_path

      #expect(response).to have_http_status(200)
      #expect(response).to be_ok
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[0][:license_plate]).to eq('ABC1234')
      expect(response.body).not_to include('CBV1234')
    end

    it 'renders empty json' do
      get api_v1_cars_path

      response_json = JSON.parse(response.body)
      expect(response).to be_ok
      expect(response.content_type).to include('application/json')
      expect(response_json).to be_empty # Como transformei em objeto ruby, posso usar métodos de array
      #expect(response.body).to eq('[]') - Jeito sem o parse
    end
  end

  context 'GET /api/v1/car/:id - Show' do
    context 'record exists' do
      let (:car) do
        create(:car, license_plate: 'ABC1234', color: 'Prata', status: :available)
      end
      it 'returns car' do
        #car = create(:car, license_plate: 'ABC1234', color: 'Prata', status: :available)
      
        #get "/api/v1/cars/#{car.id}"
        get api_v1_car_path(car)

        response_json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_ok
        expect(response_json[:license_plate]).to eq(car.license_plate)
        expect(response_json[:color]).to eq(car.color)
        expect(response_json[:car_model_id]).to eq(car.car_model_id)
      end
    end

    context 'record does not exist' do
      it 'return status code 404' do
        get '/api/v1/cars/0000'

        #Aqui quero que o status HTTP do head seja 404
        expect(response).to be_not_found
      end

      it 'returns not found message' do
        get '/api/v1/cars/0000'

        #Aqui quero que envie uma mensagem no body
        expect(response.body).to include('Carro não encontrado')
      end 
    end
  end

  context 'POST /cars - create' do
    context 'with valid parameter' do
      # let em bloco de uma linha
      let(:car_model) { create(:car_model) }
      let(:attributes) { attributes_for(:car, car_model_id: car_model.id)}
    
      it 'returns 201 status' do
        post '/api/v1/cars', params: { car: attributes }

        expect(response).to have_http_status(201)
      end

      it 'creates a car' do
        post '/api/v1/cars', params: { car: attributes }

        car = JSON.parse(response.body, symbolize_names: true)
        expect(car[:license_plate]).to eq(attributes[:license_plate])
        expect(car[:color]).to eq(attributes[:color])
        expect(car[:car_model_id]).to eq(attributes[:car_model_id])
      end
    end 
    
    context 'with invalid parameters' do
      it 'without requested params' do
        # Não pode mandar um params vazio porque quebra
        post '/api/v1/cars', params: { car: { foo: 'bar' } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Placa não pode ficar em branco')
        expect(response.body).to include('Modelo é obrigatório(a)')
      end

      it 'without car key' do
        # Mandondo sem params nenhum
        post '/api/v1/cars'

        expect(response).to have_http_status(:precondition_failed)
        expect(response.body).to include('Parâmetros inválidos')
      end
    end
  end

  context 'Delete /api/v1/car/:id - delete' do
    let (:car) do
      create(:car, license_plate: 'ABC1234', color: 'Prata', status: :available)
    end
    context 'record exists' do
      it 'returns status ok' do
        delete api_v1_car_path(car)

        expect(response).to have_http_status(:ok)
      end

      it 'returns confirmation message' do
        delete api_v1_car_path(car)

        expect(response).to be_ok
        expect(response.body).to include('Registro excluído com sucesso')
      end
    end

    context 'record does not exist' do
      it 'returns status not found' do
        delete api_v1_car_path(id: 0)

        expect(response).to have_http_status(:not_found)
      end

      it 'returns car not found' do
        delete api_v1_car_path(id: 0)

        expect(response.body).to include('Registro não encontrado')
      end
    end
  end
end

class RentalSubsidiariesController < ApplicationController
  def index
    @rental_subsidiaries = RentalSubsidiary.all
  end

  def show
    #puts '==================='
    #puts params
    #puts '==================='
    @rental_subsidiary = RentalSubsidiary.find(params[:id])
  end

  def new
    @rental_subsidiary = RentalSubsidiary.new
  end

  def create
    #puts '==================='
    #puts params
    #puts '==================='
    @rental_subsidiary = RentalSubsidiary.create(rental_subsidiary_params)
    
    #redirect_to rental_subsidiary_path(id: @rental_subsidiary.id)
    redirect_to @rental_subsidiary
  end

  def edit
    @rental_subsidiary = RentalSubsidiary.find(params[:id])
  end

  def update
    @rental_subsidiary = RentalSubsidiary.find(params[:id])
    if @rental_subsidiary.update(rental_subsidiary_params)
      redirect_to @rental_subsidiary #show
    else
      render :edit #render para ter acesso aos meus erros
    end
  end

private

  def rental_subsidiary_params
    params.require(:rental_subsidiary)
          .permit(:name, :cnpj, :adress)
  end
end
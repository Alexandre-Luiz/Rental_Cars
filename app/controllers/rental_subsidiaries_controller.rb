class RentalSubsidiariesController < ApplicationController
  def index
    @rental_subisidiaries = RentalSubsidiary.all
  end

  def show
    #puts '==================='
    #puts params
    #puts '==================='
    @rental_subisidiary = RentalSubsidiary.find(params[:id])
  end
end
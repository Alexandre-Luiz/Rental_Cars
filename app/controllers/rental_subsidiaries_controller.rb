class RentalSubsidiariesController < ApplicationController
  def index
    @rental_subisidiaries = RentalSubsidiary.all
  end
end
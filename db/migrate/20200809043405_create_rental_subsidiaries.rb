class CreateRentalSubsidiaries < ActiveRecord::Migration[6.0]
  def change
    create_table :rental_subsidiaries do |t|
      t.string :name
      t.string :cnpj
      t.string :adress

      t.timestamps
    end
  end
end

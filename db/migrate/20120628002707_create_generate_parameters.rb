class CreateGenerateParameters < ActiveRecord::Migration
  def change
    create_table :generate_parameters do |t|
      t.text :data

      t.timestamps
    end
  end
end

class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.date :date
      t.time :time
      t.string :location
      t.decimal :XCoord
      t.decimal :YCoord
      t.boolean :arrest

      t.timestamps
    end
  end
end

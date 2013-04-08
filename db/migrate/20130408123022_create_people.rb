class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :version_id
      t.string :name
      t.boolean :is_maintainer
      t.timestamps
    end
  end
end

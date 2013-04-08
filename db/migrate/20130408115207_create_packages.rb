class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.name
      t.timestamps
    end
  end
end

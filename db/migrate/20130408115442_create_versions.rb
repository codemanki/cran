class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :package_id
      t.string :version
      t.datetime :version_date
      t.string :title
      t.string :description
      t.string :license
      t.datetime :packaged
      t.datetime :published
      t.timestamps
    end
  end
end

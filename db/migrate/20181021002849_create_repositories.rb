class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.string :repository, null: false
      t.string :description, null: false
      t.string :language

      t.timestamps null: false
    end
  end
end

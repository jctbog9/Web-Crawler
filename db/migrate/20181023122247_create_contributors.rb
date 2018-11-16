class CreateContributors < ActiveRecord::Migration[5.2]
  def change
    create_table :contributors do |t|
      t.string :contributor, null: false

      t.timestamps null: false
    end
  end
end

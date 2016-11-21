class CreateAttempts < ActiveRecord::Migration[5.0]
  def change
    create_table :attempts do |t|
      t.integer :user_id
      t.integer :snippet_id
      t.integer :score
      t.float :accuracy

      t.timestamps
    end
  end
end

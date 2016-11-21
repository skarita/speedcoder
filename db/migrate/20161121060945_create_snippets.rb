class CreateSnippets < ActiveRecord::Migration[5.0]
  def change
    create_table :snippets do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.text :body
      t.string :language
      t.integer :word_count

      t.timestamps
    end
  end
end

class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
    #Esto sirve para que a un usuario no le pueda añadir dos veces a favoritos un mismo producto
    add_index :favorites, [:user_id, :product_id], unique: true
  end
end

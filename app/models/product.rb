class Product < ApplicationRecord

    #Filtraciones de texto

    include Favoritable


    #Fin filtraciones

    has_one_attached :photo

    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true

    belongs_to :category
    belongs_to :user, default: -> { Current.user}

    def owner?
        #Si le quitamos el ampersen daria error, por lo cual le añadimos eso y lo que hace es una especie de comprobacion de si existe o no y por eso se lo ponemos, por si entran para navegar como invitados
        user_id == Current.user&.id
    end
end

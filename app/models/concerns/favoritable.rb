module Favoritable
    extend ActiveSupport::Concern
    
    included do

        has_many :favorites, dependent: :destroy

        
        def favorite!
            favorites.create(user: Current.user)
        end
        #el simbolo !, significa que haremos cambios y por eso lo ponemos
        def unfavorite!
            #favorites.find_by(user: Current.user).destroy
            favorite.destroy
            #version simplificada
        end
    
        def favorite
            favorites.find_by(user: Current.user)
        end
    end
end
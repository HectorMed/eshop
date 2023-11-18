class FavoritesController < ApplicationController

    def index
        
    end

    def create
        product.favorite!
        #Favorite.create(product: product, user: Current.user)
        # redirect_to product_path(product)
        respond_to do |format|
            format.html do
                redirect_to product_path(product)
            end
            format.turbo_stream do
                render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: {product: product}) 
            end
        end
    end
 
    def destroy
        product.unfavorite!
        #product.favorites.find_by(user: Current.user).destroy
        #redirigir a la pagina del producto
        # redirect_to product_path(product), status: :see_other
        respond_to do |format|
            format.html do
                redirect_to product_path(product), status: :see_other
            end
            format.turbo_stream do          #reemplaza por medio de un id en un elemento HTML
                render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: {product: product}) 
            end
        end
    end


    private
    def product
        @product ||= Product.find(params[:product_id])
    end
end
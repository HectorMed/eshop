class UsersController < ApplicationController
    #Se salta la verificacion de proteccion porque en este apartado es innecesario
    skip_before_action :protect_pages, only: :show
    def show
        #el signo "!" es para ver si existe o no el usuario y en caso de que no, salta una excepcion y el resto del procedimiento se detiene
        @user = User.find_by!(username: params[:username])
        # @pagy, @products = pagy_countless(FindProducts.new.call( {user_id: @user.id} ).load_async, items: 12)
    end
    
end
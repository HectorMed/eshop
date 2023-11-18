#al estar dentro de un name space, primero se declara el namespace y despues va el nombre de la clase
class Authentication::UsersController < ApplicationController
    #Saltarse el callback de proteccion de paginas porque aqui es innecesario
    skip_before_action :protect_pages

    
   def new
    @user = User.new
   end

   def create
    @user = User.new(user_params)

    if @user.save
        session[:user_id] = @user.id
        redirect_to products_path, notice: 'Tu cuenta ha sido creada con exito!'
    else
        render :new, status: :unprocessable_entity
    end
   end
   

   private
   def user_params
                #objeto user, que se enviará con los parametros de inicio de sesion
    params.require(:user).permit(:email, :username, :password)
   end

end
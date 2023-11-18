class Authentication::SessionsController < ApplicationController

    #Saltarse el callback de proteccion de paginas porque aqui es innecesario
    skip_before_action :protect_pages
    def new
        
    end

    def create

        @user = User.find_by("email = :login OR username = :login", { login: params[:login]})


        if @user&.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to products_path, notice: 'Haz iniciado sesion'
        else
            redirect_to new_session_path, alert: 'Login invalido'
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to products_path, notice: 'Sesion destruida'
    end
    
end
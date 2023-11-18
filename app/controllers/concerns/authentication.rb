module Authentication
    extend ActiveSupport::Concern

    included do
        before_action :set_current_user
        #CallBack para proteger todas las paginas
        before_action :protect_pages
        #El nombre puede ser cualquiera

        private
        def set_current_user
            #esto busca un usuario por su ID
            #Esto solo se ejecuta cuando la sesion tiene una session ID, como login o register
            Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
        end 
    
        def protect_pages           #Unless significa, "SI NO"
            redirect_to new_session_path, alert: 'Debes iniciar sesion' unless Current.user
        end  
    end
end
module Authorization
    extend ActiveSupport::Concern

    included do
        class NotAuthorizedError < StandardError
        
        end
        #Cuando hay una excepcion, se ejctua este codigo con mensaje de error "No autorizado"
        rescue_from NotAuthorizedError do
            redirect_to products_path, alert: 'No autorizado'
        end

        private
        def authorize! record = nil
            is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)
            #El classify sirve para hacer camelCase, basicamente porque el controller name
            #empieza con minuscula y nosotros lo necesitamos en mayusculas
            
            raise NotAuthorizedError unless is_allowed
            # redirect_to products_path, alert: 'No autorizado' unless is_allowed
        end
    end
end
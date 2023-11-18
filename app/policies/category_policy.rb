class CategoryPolicy < BasePolicy
    #hereda de base policy y hace que podamos usar las variables de instancia 

    def method_missing(m, *args, &block)
        Current.user.admin?
    end

#Esto de abajo es lo mismo de arriba pero arriba es mas limpio y mejor    
    # def index
    #     Current.user.admin?
    # end

    # def new
    #     Current.user.admin?
    # end

    # def create
    #     Current.user.admin?
    # end
    
    # def edit
    #     Current.user.admin?
    # end
    
    # def update
    #     Current.user.admin?
    # end

    # def destroy
    #     Current.user.admin?
    # end
end
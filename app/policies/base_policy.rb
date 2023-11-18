#clase padre que va a heredar las variables para que se pueda usar desde aqui, y no que cada variable tenga una variable por separado

class BasePolicy
    #esto es para que podamos modificar y leer la variable de instancia
    attr_reader :record



    #este metodo es para pasarle la variable de instancia
    def initialize(record)
      @record = record
    end

    #Este metodo es para que cuando alguien viole las policies y el metodo
    #no exista, entonces no salga un error de ruby

    def method_missing(m, *args, &block)
      false
    end
    

end
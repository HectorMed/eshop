#Usar plural en los controladores

class ProductsController < ApplicationController

    #Para validar la proteccion de esta pagina
    skip_before_action :protect_pages, only: [:index, :show]

    #EL METODO LOAD_ASYNC SIEMPRE DEBE IR ABAJO DEL TODO
    
    #Metodos, el INDEX es para devolver conjuntos de cosas
    def index
        #Para hacer un metodo de filtracion por categorias
        @categories = Category.all.order(name: :asc).load_async #esto permite ejecutar de manera paralela o asincrona funciones

        #El @ lo convierte en variable de instancia 
        #Eso hace posible que podamos leerlo en otros archivos
        # @products = Product.all

        #Para las consultas query de filtrado por categorias
        # if params[:category_id]
        #     @products = @products.where(category_id: params[:category_id])
        # end

        #Ifs para poner rangos de precio
        # if params[:min_price].present?
        #     @products = @products.where('price >= ?', params[:min_price])
        # end

        # if params[:max_price].present?
        #     @products = @products.where('price <= ?', params[:max_price])
        # end

        #Filtrato por mas caros, baratos o nuevos
        #PRIMERA FORMA
        # if params[:order_by].present?
        #     order_by = {
        #         newest: "created_at DESC",
        #         expensive: "price DESC",
        #         cheapest: "price ASC"
        #     }.fetch(params[:order_by].to_sym, "created_at DESC")

        #     @products = @products.order(order_by)
        # end
        #SEGUNDA FORMA SIN IF

            # order_by = {
            #     newest: "created_at DESC",
            #     expensive: "price DESC",
            #     cheapest: "price ASC"
            # }.fetch(params[:order_by]&.to_sym, "created_at DESC")

            # @products = @products.order(order_by).load_async
    
            # @pagy, @products = pagy_countless(@products, items: 9)
            @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async, items: 12)
    end

    def show
        #Metodo para mostrar un solo producto
        # @product = Product.find(params[:id])
        product
        #Ya que es codigo repetido, podemos crear una funcion y llamarla en vez de repetir codigo, recuerda el DRY
        
    end

    def new
        #metodo para la creacion de productos
        @product = Product.new
    end

    def create
        #Este metodo sirve para pasarle los parametros al metodo de creacion
        @product = Product.new(product_params)

        if @product.save
            redirect_to products_path, notice: 'Captura exitosa!'
        else
            render :new, status: :unprocessable_entity
        end   
    end

    def edit 
        #@product = Product.find(params[:id])
         #CODIGO QUE METI EN EL METODO DE ABAJO 
        #metodo que me invente para no usar gemas
         authorize! product
        #  product
    end
    
    def update
        #@product = Product.find(params[:id])
        #CODIGO QUE METI EN EL METODO DE ABAJO 
        authorize! product
            #Al metodo UPDATE se le deben pasar los parametros que se desean actualizar
        if product.update(product_params)
            redirect_to products_path, notice: 'Producto Actualizado!'
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        authorize! product
        #CODIGO QUE METI EN EL METODO DE ABAJO 
        #@product = Product.find(params[:id])
        product.destroy
        redirect_to products_path, notice: 'Producto Eliminado', status: :see_other
    end
    


    private
    def product_params
        #Lo que hace esto es pasarle como argumento el objeto product que contiene todos los campos del formulario
        #y se lo pasa a los parametros de la funcion create
        #asi mismo, el metodo "permit" lo que hace permitir que solo esos atributos se inserten en la Base de datos
        params.require(:product).permit(:title, :description, :price, :photo, :category_id)
    end

    def product_params_index
        params.permit(:category_id, :min_price, :max_price, :order_by, :page, :favorites, :user_id)
    end
    

    def product
        @product ||= Product.find(params[:id])
    end
end
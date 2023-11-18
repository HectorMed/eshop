class ApplicationController < ActionController::Base
    include Authentication #este va primero porque primero hacemos logins
    include Authorization  #este va despues porque se verifican los permisos de usuarios
    include Pagy::Backend  #Este de ultimo porque luego de comprobar, ya imprime la pagina
    include Error #Este se encarga de desplegar errores de la pagina 

    #Al crear carpetas y archivos nuevos siempre hay que reiniciar el servidor en caso de fallos ya que el servidor no actualiza las rutas en automatico

    

    #CallBacks
    #CallBack el cual es para que antes de cualquier accion, se valide que el usuario es el que esta haciendo una peticion
    #Una variable de instancia está disponible en el controlador y las vistas  
end


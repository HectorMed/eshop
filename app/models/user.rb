class User < ApplicationRecord
    has_secure_password
    #esto añade todos los metodos para el tema de guardar contraseñas encriptadas
    
    validates :email, presence: true, uniqueness: true,
    format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: :invalid
    }
    validates :username, presence: true, uniqueness: true, length: {minimum:5, maximum:15}, 
    format: {
        with: /\A[a-z0-9A-Z]+\z/,
        message: :invalid
      }
    validates :password, length: {minimum:5, maximum:30}

    #Un usuario puede tener varios productos, en caso de que el usuario se elimine, todos los productos referentes a el, igual
    has_many :products, dependent: :destroy

    #un usuario puede tener varios favoritos
    has_many :favorites, dependent: :destroy

    before_save :downcase_att

    private
    def downcase_att
      self.username = username.downcase
      self.email = email.downcase
    end
    
end

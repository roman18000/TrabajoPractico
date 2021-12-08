class Professional < ApplicationRecord
    #creo que el restric es para que no se pueda borrar un profesional si tienen turnos 
    has_many :appointments, :dependent: :restrict_with_error 

    validates :name, presence: true, uniqueness: true 
end

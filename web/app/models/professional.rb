class Professional < ApplicationRecord
    #creo que el restric es para que no se pueda borrar un profesional si tienen turnos 
    # , :dependent , :restrict_with_error  agregar eso sin que tire error
    has_many :appointments

    validates :name, presence: true, uniqueness: true 

    def destroy
        raise "Cannot delete professional with appointments" unless appointments.count == 0
        super
    end
end

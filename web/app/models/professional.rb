class Professional < ApplicationRecord
    #creo que el restric es para que no se pueda borrar un profesional si tienen turnos 
    # , :dependent , :restrict_with_error  agregar eso sin que tire error
    has_many :appointments

    validates :name, presence: true, uniqueness: true 

    def destroy
        raise "Cannot delete professional with appointments" unless appointments.count == 0
        super
    end

    def date_repeat(date)
        v = false
        appointments.each do |a|
            if a.date.year == date.year and a.date.month == date.month and a.date.day == date.day
                if a.date.hour == date.hour
                    v = true
                end
            end
        end
        v 
    end
end

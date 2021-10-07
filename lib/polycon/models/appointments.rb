module Polycon
    module Models
        module Appointments
            
            
            def self.add_appointment(date, professional, name, surname, phone, notes=nil)
                if Polycon::Models::Utils.ensure_professional_root_exists(professional) 
                    puts "El profesional ingresado no existe"
                else
                    #crear el archivo y guarlo en el directorio correspondiente
                end 
            end


        end
    end
end
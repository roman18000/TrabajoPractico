require 'date'
module Polycon
    module Models
        module Utils
            #validadores----------------->
            def self.ensure_polycon_root_exists
                #Creo el directorio si no existe
                Dir.mkdir('/home/polycon/') unless File.exist?('/home/polycon/')
            end
            
            def self.ensure_professional_root_exists(professional)
                File.exist?('/home/polycon/') && File.exist?("/home/polycon/#{professional}") 
            end

            def self.ensure_professional_has_not_appointments(professional)
                (Dir["/home/polycon/#{professional}/*"]).empty?  #retorna true si no tiene turnos
            end

            def self.validate_appointment(date,professional)
                #llamo a un metodo local para chequear la fecha y otro para chequear si el profesional existe
                true
            end

            def self.create_date(stringDate)
                DateTime.parse(stringDate) #retorno un date time
            end


        end
    end 
end
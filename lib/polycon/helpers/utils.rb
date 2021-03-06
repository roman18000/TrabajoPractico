require 'date'
module Polycon
    module Helpers
        module Utils
            @@home = Dir.home
            #validadores----------------->
            def self.ensure_polycon_root_exists
                #Creo el directorio si no existe
                Dir.mkdir("#{@@home}/polycon/") unless File.exist?("#{@@home}/polycon/")
            end
            
            def self.ensure_professional_root_exists(professional)
                if not (File.exist?("#{@@home}/polycon/#{professional}"))
                    raise "El profesional no existe"
                end 
            end

            def self.ensure_professional_has_not_appointments(professional)
                if not ((Dir["#{@@home}/polycon/#{professional}/*"]).empty?)
                    raise "El profesional tiene turnos"
                end
            end
                #seguir aca, la fecha esta como date cambiar eso? por date.year- .....
            def self.ensure_appointment_exist(file_name, professional)
                if not (File.exist?("#{file_name}"))
                    raise "El turno ingresado no existe"
                end
            end

            #devuelve true si el formato es valido
            def self.validete_date_format(date)
                if not (date =~ /^\d{4}\-\d{1,2}\-\d{1,2}\ \d{2}\:\d{2}$/ )
                    raise "El formato de la fecha es invalido"
                end
            end

           
            def self.validete_date_format_list(date)
                if not (date =~ /^\d{4}\-\d{1,2}\-\d{1,2}$/) 
                    raise "El formato ingresado para listar es incorrecto"
                end
            end 

            def self.validate_hour(hour ,professional)
                Dir.glob("*",base:"#{@@home}/polycon/#{professional}").map do |filename|
                        date = filename_turn_into_date(filename)
                        if date.hour == hour
                            raise "La hora ingresada para el turnos se superpone con otro turno, los rangos de turnos son de una hora"
                        end
                end
            end
           
            def self.validete_date(date)
                today = DateTime.now
                if date < today
                    raise "La fecha debe ser mayor"
                end
            end

            def self.return_appointment(date, professional)
                dateName = "#{date.year}-#{date.month}-#{date.day}_#{date.hour}-#{date.minute}"
                a = Dir.glob("#{dateName}",base:"#{@@home}/polycon/#{professional}/")
                if a.empty?
                    raise "El turno ingresado no existe para ese profesional"
                else 
                    a.first
                end
            end 

            def self.return_appointments_for_professional(professional)
                Dir.glob("*",base:"#{@@home}/polycon/#{professional}/")
            end

            def self.filename_turn_into_date(filename)
                a = filename.split("_")  #separo la hora de la fecha
                a[1] = a[1].gsub("-",":")  #cambio el formato de la fecha de 13-0 a 13:00
                DateTime.parse("#{a[0]} #{a[1]}")   #retorno la fecha

            end

            def self.validete_name(name)
                if not (name =~ /\w/)
                    raise "El formato de nombre ingresado es invalido"
                end
            end 


            def self.create_date(stringDate)
                DateTime.parse(stringDate) #retorno un date time
            end

            


        end
    end 
end
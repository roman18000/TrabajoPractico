require 'prawn'
require 'prawn/table'

module Polycon
    module Helpers 
        module Exports
            @@home = Dir.home

            def self.ensure_polycon_files_root_exists
                #Creo el directorio si no existe
                Dir.mkdir("#{@@home}/polycon_files/") unless File.exist?("#{@@home}/polycon_files/")
            end

            
            def self.export_list(date, name, list)
                professionals_names = list.map{|a| a.professional}
                professionals_names = professionals_names.uniq
                professionals_names = professionals_names * ","
                data = [["Hora", "Paciente", "Profesional"]]
                Prawn::Document.generate("#{@@home}/polycon_files/#{name}.pdf") do
                    text "Turnos para el dia #{date} de/los profesional/es #{professionals_names}"
                    list.each do |a|
                        data += [["#{a.hour_min}", "#{a.name} #{a.surname}", "#{a.professional}"]]
                    end
                    table data do |table|
                        table.column_widths = [50,150]
                    end
                end 
            end 

            #value es un arreglos de arreglos, por ejemplo en la key= hora del dia, me da un valor ese valor es un arreglo de los 7 dias, cada dia a su vez es un arreglo 
            def self.export_list_week(date, name, hash)
                data = [["Hora", "Domingo", "Lunes", "Martes", "Miercoles", "Juves", "Viernes", "Sabado"]]
                Prawn::Document.generate("#{@@home}/polycon_files/#{name}.pdf") do
                    text "Turnos para la semana del #{date} de/los profesinal/es"
                    hash.each do |key,value|
                        data += [["#{key}:00", "#{value[0].join("\n\n")}", "#{value[1].join("\n\n")}", "#{value[2].join("\n\n")}", "#{value[3].join("\n\n")}", "#{value[4].join("\n\n")}", "#{value[5].join("\n\n")}", "#{value[6].join("\n\n")}" ]]
                    end
                    table data do |table|
                        table.column_widths = [50,150]
                    end
                end 
     
            end
            
        


        end
    end
end
require 'prawn'
require 'prawn/table'

module Polycon
    module Models
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

        end
    end
end
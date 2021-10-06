module Polycon
    module Models
        module Professionals

            def self.add_professional(name)
                Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                Dir.mkdir("/home/polycon/#{name}/") unless File.exist?("/home/polycon/#{name}/") #Creo el directorio del profesional si no existe
                puts "Agregado correctamente"
            end

            def self.list_professionals
                Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                list = Dir.entries('/home/polycon')  #obtengo todos los directorios de polycon
                list.delete(".")    #borro del array el . y ..
                list.delete("..")
                puts list
            end

            def self.rename_professional(old_name, new_name)
                Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                File.rename("/home/polycon/#{old_name}", "/home/polycon/#{new_name}")
                puts "El profesional se renombro correctamente"
            end

            # def delete_professional(name)
            # end 

            class Professionals 
                def initialize(name)
                    @name = name
                end
            end 

        end
    end
end 

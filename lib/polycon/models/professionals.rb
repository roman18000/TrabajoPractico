module Polycon
    module Models
        class Professionals

            def self.add_professional(name)
                Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                Dir.mkdir("/home/polycon/#{name}/") unless File.exist?("/home/polycon/#{name}/") #Creo el directorio del profesional si no existe
                puts "Agregado correctamente"
                new(name)

            end 

            def self.list_professionals
                Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                list = Array.new
                Dir.entries('/home/polycon').map do |directory|
                    if (directory != "." && directory != "..")
                        list << new(directory)
                    end
                end
                puts list
            end

            def self.rename_professional(old_name, new_name)
                Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                File.rename("/home/polycon/#{old_name}", "/home/polycon/#{new_name}")
                puts "El profesional se renombro correctamente"
                #si estaria guardada las instancia lo busco y le cambio el nombre
            end

            def self.delete_professional(name)
                if Polycon::Models::Utils.ensure_professional_root_exists(name)
                    if Polycon::Models::Utils.ensure_professional_has_not_appointments(name)
                        Dir.rmdir("/home/polycon/#{name}")
                    else
                        puts "El profesional tiene turnos"
                    end
                else 
                    puts "El profesional no existe"
                end
            end

            attr_accessor :name

            def initialize(name)
                self.name = name
            end

            def to_s
                name
            end

        end




        # module Professionals

        #     def self.add_professional(name)
        #         Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
        #         Dir.mkdir("/home/polycon/#{name}/") unless File.exist?("/home/polycon/#{name}/") #Creo el directorio del profesional si no existe
        #         puts "Agregado correctamente"
        #     end

        #     def self.list_professionals
        #         Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
        #         list = Dir.entries('/home/polycon')  #obtengo todos los directorios de polycon
        #         list.delete(".")    #borro del array el . y ..
        #         list.delete("..")
        #         puts list
        #     end

        #     def self.rename_professional(old_name, new_name)
        #         Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
        #         File.rename("/home/polycon/#{old_name}", "/home/polycon/#{new_name}")
        #         puts "El profesional se renombro correctamente"
        #     end

        #     # def delete_professional(name)
        #     # end 
        # end
    end
end 

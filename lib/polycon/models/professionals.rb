module Polycon
    module Models
        class Professionals
            @@home = Dir.home
            def self.add_professional(name)
                Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                Polycon::Models::Utils.validete_name(name)
                Dir.mkdir("#{@@home}/polycon/#{name}/") unless File.exist?("#{@@home}/polycon/#{name}/") #Creo el directorio del profesional si no existe
                new(name)
            end 

            def self.list_professionals
                Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                list = Array.new
                Dir.children("#{@@home}/polycon/").map do |directory|
                    list << new(directory)
                end
                list
            end

            def self.rename_professional(old_name, new_name)
                begin
                    Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                    Polycon::Models::Utils.ensure_professional_root_exists(old_name)
                    File.rename("#{@@home}/polycon/#{old_name}", "#{@@home}/polycon/#{new_name}")
                rescue => e
                    raise e.message
                end
                #si estaria guardada las instancia lo busco y le cambio el nombre
            end

            def self.delete_professional(name)
                Polycon::Models::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                begin
                    Polycon::Models::Utils.ensure_professional_root_exists(name)
                    Polycon::Models::Utils.ensure_professional_has_not_appointments(name)
                    Dir.rmdir("#{@@home}/polycon/#{name}")
                rescue => e
                    raise e.message
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

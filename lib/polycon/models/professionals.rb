module Polycon
    module Models
        class Professionals
            @@home = Dir.home
            def self.add_professional(name)
                Polycon::Helpers::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                Polycon::Helpers::Utils.validete_name(name)
                Dir.mkdir("#{@@home}/polycon/#{name}/") unless File.exist?("#{@@home}/polycon/#{name}/") #Creo el directorio del profesional si no existe
                new(name)
            end 

            def self.list_professionals
                Polycon::Helpers::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                list = Array.new
                Dir.children("#{@@home}/polycon/").map do |directory|
                    list << new(directory)
                end
                list
            end

            def self.rename_professional(old_name, new_name)
                begin
                    Polycon::Helpers::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                    Polycon::Helpers::Utils.ensure_professional_root_exists(old_name)
                    File.rename("#{@@home}/polycon/#{old_name}", "#{@@home}/polycon/#{new_name}")
                rescue => e
                    raise e.message
                end
                #si estaria guardada las instancia lo busco y le cambio el nombre
            end

            def self.delete_professional(name)
                Polycon::Helpers::Utils.ensure_polycon_root_exists #me aseguro que exista la ruta
                begin
                    Polycon::Helpers::Utils.ensure_professional_root_exists(name)
                    Polycon::Helpers::Utils.ensure_professional_has_not_appointments(name)
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

    end
end 

module Polycon
    module Models
        module Utils
            def self.ensure_polycon_root_exists
                #Creo el directorio si no existe
                Dir.mkdir('/home/polycon/') unless File.exist?('/home/polycon/')
            end
        end
    end 
end
module Polycon
    module Models
        module Professionals
            @professionals_list = Array.new

            def self.add(name)
                p = Professionals.new(name)
                @professionals_list << p
                puts "Se agrego correctamente"
            end

            class Professionals 
                def initialize(name)
                    @name = name
                end
            end 

        end
    end
end 

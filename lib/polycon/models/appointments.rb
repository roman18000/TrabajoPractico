module Polycon
    module Models
        class Appointments
            
            def self.add_appointment(date, professional, name, surname, phone, notes="")
                path = "/home/polycon/#{professional}/"
                file_name="#{path}/#{date.year}-#{date.month}-#{date.day}_#{date.hour}-#{date.minute}"
                puts "Turno creado correctamente"
                File.open("#{file_name}", "a+") do |a|
                    a << "#{surname}/n"
                    a << "#{name}/n"
                    a << "#{phone}/n"
                    a << "#{notes}/n"
                end 
            end



        end
    end
end
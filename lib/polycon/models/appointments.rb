module Polycon
    module Models
        class Appointments
            @@home = Dir.home

            def self.add_appointment(dateString, professional, name, surname, phone, notes)
                begin
                    Polycon::Models::Utils.validete_date_format(dateString)
                    Polycon::Models::Utils.ensure_professional_root_exists(professional)
                    date = Polycon::Models::Utils.create_date(dateString)
                    Polycon::Models::Utils.validete_date(date)
                    path = "#{@@home}/polycon/#{professional}/"
                    file_name="#{path}/#{date.year}-#{date.month}-#{date.day}_#{date.hour}-#{date.minute}"
                    File.open("#{file_name}", "a+") do |a|
                        a.puts "#{surname}"
                        a.puts "#{name}"
                        a.puts "#{phone}"
                        a.puts "#{notes}"
                    end
                    new(date,professional,name,surname,phone,notes)
                rescue => e
                    raise e.message
                end
            end

            
            def self.show_appointment(dateString, professional)
                begin 
                    Polycon::Models::Utils.validete_date_format(dateString)
                    Polycon::Models::Utils.ensure_professional_root_exists(professional)
                    date = Polycon::Models::Utils.create_date(dateString)
                    nameFile = Polycon::Models::Utils.return_appointment(date, professional)
                    path = "#{@@home}/polycon/#{professional}/#{nameFile}"
                    list = Array.new
                    f = File.open("#{path}","r")
                    f.readlines.map { |line| list << line}
                    list.map { |l| l.gsub("\n","")}
                    new(date,professional,list[1], list[0], list[2], list[3])
                rescue => e
                    raise e.message
                end
            end

            def self.cancel_appointment(dateString, professional)
                begin 
                    Polycon::Models::Utils.validete_date_format(dateString)
                    Polycon::Models::Utils.ensure_professional_root_exists(professional)
                    date = Polycon::Models::Utils.create_date(dateString)
                    nameFile = Polycon::Models::Utils.return_appointment(date, professional)
                    File.delete("#{@@home}/polycon/#{professional}/#{nameFile}")
                rescue => e
                    raise e.message
                end
            end 

            def self.cancel_all_appointments(professional)
                begin
                    Polycon::Models::Utils.ensure_professional_root_exists(professional)
                    Dir.glob("*",base:"#{@@home}/polycon/#{professional}/").each do |nameFile|
                        File.delete("#{@@home}/polycon/#{professional}/#{nameFile}")
                    end
                rescue => e
                    e.message
                end
            end 

            def self.reschedule_appointment(old_dateString, new_dateString, professional)
                begin
                    Polycon::Models::Utils.validete_date_format(old_dateString)   #valido que el formato de las fechas ingresada sea valido
                    Polycon::Models::Utils.validete_date_format(new_dateString)
                    Polycon::Models::Utils.ensure_professional_root_exists(professional)  #valido que el profesional existe
                    old_date = Polycon::Models::Utils.create_date(old_dateString)         #convierto el string en un date
                    new_date = Polycon::Models::Utils.create_date(new_dateString)        
                    Polycon::Models::Utils.validete_date(new_date)                  #valido que la fecha nueva sea valida
                    old_file_name = "#{@@home}/polycon/#{professional}/#{old_date.year}-#{old_date.month}-#{old_date.day}_#{old_date.hour}-#{old_date.minute}"
                    new_file_name = "#{@@home}/polycon/#{professional}/#{new_date.year}-#{new_date.month}-#{new_date.day}_#{new_date.hour}-#{new_date.minute}"
                    Polycon::Models::Utils.ensure_appointment_exist(old_file_name, professional)  #valido que la fecha ingresada exista
                    File.rename("#{old_file_name}", "#{new_file_name}")
                rescue => e
                    raise e.message
                end
            end

            attr_accessor :date, :professional, :name, :surname, :phone, :notes

            def initialize(date, professional, name, surname, phone, notes=nil)
                self.date = date
                self.professional = professional
                self.name = name
                self.surname = surname
                self.phone = phone
                self.notes = notes
            end

            def to_s
                "Fecha: #{self.date} Apellido: #{self.surname} Nombre: #{self.name} Telefono: #{self.phone} Notas: #{self.notes} "
            end



        end
    end
end
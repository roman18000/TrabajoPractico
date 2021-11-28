module Polycon
    module Models
        class Appointments
            @@home = Dir.home

            def self.add_appointment(dateString, professional, name, surname, phone, notes)
                begin
                    Polycon::Helpers::Utils.validete_date_format(dateString)
                    Polycon::Helpers::Utils.ensure_professional_root_exists(professional)
                    date = Polycon::Helpers::Utils.create_date(dateString)
                    Polycon::Helpers::Utils.validete_date(date)
                    Polycon::Helpers::Utils.validate_hour(date.hour ,professional)
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

            
            def self.show_appointment(date, professional)
                begin 
                    Polycon::Helpers::Utils.ensure_professional_root_exists(professional)
                    nameFile = Polycon::Helpers::Utils.return_appointment(date, professional)
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
                    Polycon::Helpers::Utils.validete_date_format(dateString)
                    Polycon::Helpers::Utils.ensure_professional_root_exists(professional)
                    date = Polycon::Helpers::Utils.create_date(dateString)
                    nameFile = Polycon::Helpers::Utils.return_appointment(date, professional)
                    File.delete("#{@@home}/polycon/#{professional}/#{nameFile}")
                rescue => e
                    raise e.message
                end
            end 

            def self.cancel_all_appointments(professional)
                begin
                    Polycon::Helpers::Utils.ensure_professional_root_exists(professional)
                    Dir.glob("*",base:"#{@@home}/polycon/#{professional}/").each do |nameFile|
                        File.delete("#{@@home}/polycon/#{professional}/#{nameFile}")
                    end
                rescue => e
                    e.message
                end
            end 

            def self.reschedule_appointment(old_dateString, new_dateString, professional)
                begin
                    Polycon::Helpers::Utils.validete_date_format(old_dateString)   #valido que el formato de las fechas ingresada sea valido
                    Polycon::Helpers::Utils.validete_date_format(new_dateString)
                    Polycon::Helpers::Utils.ensure_professional_root_exists(professional)  #valido que el profesional existe
                    old_date = Polycon::Helpers::Utils.create_date(old_dateString)         #convierto el string en un date
                    new_date = Polycon::Helpers::Utils.create_date(new_dateString)        
                    Polycon::Helpers::Utils.validete_date(new_date)                  #valido que la fecha nueva sea valida
                    old_file_name = "#{@@home}/polycon/#{professional}/#{old_date.year}-#{old_date.month}-#{old_date.day}_#{old_date.hour}-#{old_date.minute}"
                    new_file_name = "#{@@home}/polycon/#{professional}/#{new_date.year}-#{new_date.month}-#{new_date.day}_#{new_date.hour}-#{new_date.minute}"
                    Polycon::Helpers::Utils.ensure_appointment_exist(old_file_name, professional)  #valido que la fecha ingresada exista
                    File.rename("#{old_file_name}", "#{new_file_name}")
                rescue => e
                    raise e.message
                end
            end

            def self.list_appointments_professional(professional)
                begin
                    Polycon::Helpers::Utils.ensure_professional_root_exists(professional)
                    list = Array.new
                    Dir.glob("*",base:"#{@@home}/polycon/#{professional}").map do |filename|
                        date = Polycon::Helpers::Utils.filename_turn_into_date(filename)
                        list << show_appointment(date,professional)
                    end
                    list
                rescue => e 
                    raise e.message
                end
            end

            # En este caso el date string coincide con el formato del nombre de los archivos
            def self.list_appointments_professional_and_date(professional, dateString)
                begin
                    Polycon::Helpers::Utils.ensure_professional_root_exists(professional)
                    Polycon::Helpers::Utils.validete_date_format_list(dateString)
                    list = Array.new
                    Dir.glob("#{dateString}*",base:"#{@@home}/polycon/#{professional}").map do |filename|
                        date = Polycon::Helpers::Utils.filename_turn_into_date(filename)
                        list << show_appointment(date,professional)
                    end
                    list
                rescue => e 
                    raise e.message
                end 
            end 


            def self.edit_appointments(dateString, professional, options)
                begin
                    Polycon::Helpers::Utils.validete_date_format(dateString)
                    Polycon::Helpers::Utils.ensure_professional_root_exists(professional)
                    d = Polycon::Helpers::Utils.create_date(dateString)
                    name_file = "#{@@home}/polycon/#{professional}/#{d.year}-#{d.month}-#{d.day}_#{d.hour}-#{d.minute}" 
                    Polycon::Helpers::Utils.ensure_appointment_exist(name_file, professional)
                    appointment = show_appointment(d,professional)
                    options.each do |key, value|
                        appointment.send("#{key}=",value)
                    end
                    save_edit(appointment, name_file)
                rescue => e 
                    raise e.message
                end 
            end

            def self.save_edit(appointment, name_file)
                File.open("#{name_file}", "w") do |a|
                    a.puts "#{appointment.surname}"
                    a.puts "#{appointment.name}"
                    a.puts "#{appointment.phone}"
                    a.puts "#{appointment.notes}"
                end
            end

            #este metodo lo que recibe hace un splat para tener un arrelgo y recorrerlo tanto como si es un profesional o si son muchos
            #ya que si no es ninguno tengo que recorrer todos, por eso lo seteo abajo
            def self.export_list_appointments_for_day_with_professional(date, *professionals)
                begin
                    name = "#{date}AllPros"
                    name = "#{date}Pro:#{professionals[0]}" if professionals != [nil]   #esto es para colocar el nombre segun corresponda
                    professionals = Polycon::Models::Professionals.list_professionals() if professionals == [nil]
                    list = list_appointments_for_day_with_professional(date,professionals)
                    Polycon::Helpers::Exports.export_list(date, name, list)
                    list
                rescue => e
                    raise e.message
                end
            end


            def self.list_appointments_for_day_with_professional(date, professionals)
                list = Array.new
                    professionals.each do |p|
                        list += list_appointments_professional_and_date(p, date)  #hago esto para no tener arreglos dentro del arrelgo, directamente le agrego
                    end
                list = list.sort_by(&:hour_min)
                list
            end


            def self.export_list_appointments_for_week_with_professional(dateString, *professionals)
                begin
                    name = "#{dateString}-WeekAllPros"
                    name = "#{dateString}-WeekPro:#{professionals[0]}" if professionals != [nil]
                    date = Polycon::Helpers::Utils.create_date(dateString)
                    professionals = Polycon::Models::Professionals.list_professionals() if professionals == [nil]
                    hash = Hash.new
                    for h in 8..17 do
                        hash["#{h}"] = []
                        days = date - date.wday # se reinicia en domingo
                        for d in 1..7 do
                            dateFormat = "#{days.year}-#{days.month}-#{days.day}"
                            hash["#{h}"] << list_appointments_for_day_with_professional_and_hour(dateFormat, professionals, h) #retorna una lista de los turnos para ese dia, para ese profecional en esa hora
                            days = days + 1
                        end
                    end
                    dateString = "#{date.year}-#{date.month}-#{date.day}"
                    Polycon::Helpers::Exports.export_list_week(dateString, name, hash)
                rescue => e
                    raise e.message
                end
            end


            def self.list_appointments_for_day_with_professional_and_hour(dateFormat, professionals, hour)
                list = Array.new
                    professionals.each do |p|
                        list += list_appointments_professional_with_date_and_hour(p, dateFormat, hour)  
                    end
                list = list.sort_by(&:hour_min)
                if list.empty?
                    list = [""]
                end
                list
            end


            def self.list_appointments_professional_with_date_and_hour(professional, dateString, hour)
                begin
                    Polycon::Helpers::Utils.ensure_professional_root_exists(professional)
                    Polycon::Helpers::Utils.validete_date_format_list(dateString)
                    list = Array.new
                    Dir.glob("#{dateString}*",base:"#{@@home}/polycon/#{professional}").map do |filename|
                        date = Polycon::Helpers::Utils.filename_turn_into_date(filename)
                        a = show_appointment(date,professional)
                        if a.hour == hour
                            list << a
                        end
                    end
                    list
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

            # def to_s
            #     "Fecha: #{self.date} Apellido: #{self.surname} Nombre: #{self.name} Telefono: #{self.phone} Notas: #{self.notes} "
            # end

            def to_s
                "Apellido: #{self.surname} Nombre: #{self.name} Telefono: #{self.phone} Notas: #{self.notes} Profesional: #{self.professional}"
            end

            def hour_min
                "#{self.date.hour}:#{self.date.min}"
            end

            def hour
                self.date.hour
            end



        end
    end
end
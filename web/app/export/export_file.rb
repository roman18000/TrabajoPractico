require 'prawn'
require 'prawn/table'

class ExportFile

    def self.export_list(params, professionals)
        a = params[:week].to_i
        dateString = "#{params["date(1i)"]}-#{params["date(2i)"]}-#{params["date(3i)"]}"
        date = DateTime.parse(dateString)
        if a == 0
            list = []
            professionals.each do |p|
                p.appointments.each do |appointment|
                    if (appointment.date.year == date.year) && (appointment.date.month == date.month) && (appointment.date.day == date.day)   
                        list << appointment
                    end 
                end
            end
            list = list.sort_by(&:hour)
            export_list_day(dateString, list)
        else
            hash = Hash.new
            for h in 8..17 do
                hash["#{h}"] = []
                day = date - date.wday 
                for d in 1..7 do
                    hash["#{h}"] << list_appointments_for_day_with_professional_and_hour(day, professionals, h)
                    day = day + 1
                end
            end
            export_list_week(dateString, hash)
        end
    end



    private 

        def self.export_list_day(date, list)
            data = [["Hora", "Paciente", "Profesional"]]
            Prawn::Document.new do
                text "Turnos para el dia #{date} de/los profesional/es "
                list.each do |a|
                    data += [["#{a.hour}", "#{a.name} #{a.surname}", "#{a.professional.name}"]]
                end
                table data do |table|
                    table.column_widths = [50,150]
                end
            end.render
        end 

        def self.export_list_week(date, hash)
            data = [["Hora", "Domingo", "Lunes", "Martes", "Miercoles", "Juves", "Viernes", "Sabado"]]
            Prawn::Document.new do
                text "Turnos para la semana del #{date} de/los profesional/es"
                hash.each do |key,value|
                    data += [["#{key}:00", "#{value[0].join("\n\n")}", "#{value[1].join("\n\n")}", "#{value[2].join("\n\n")}", "#{value[3].join("\n\n")}", "#{value[4].join("\n\n")}", "#{value[5].join("\n\n")}", "#{value[6].join("\n\n")}" ]]
                end
                table data do |table|
                    table.column_widths = [50,150]
                end
            end.render
        end 


        

        def self.list_appointments_for_day_with_professional_and_hour(day, professionals, h)
            list = Array.new
            professionals.each do |p|
                list += list_appointments_professional_with_date_and_hour(p, day, h)
            end
            list = list.sort_by(&:hour)
            if list.empty?
                list = [""]
            end
            list
        end


        def self.list_appointments_professional_with_date_and_hour(professional, day, hour)
            list = Array.new
            professional.appointments.each do |appointment|
                if (appointment.date.year == day.year) && (appointment.date.month == day.month) && (appointment.date.day == day.day)
                    if appointment.date.hour == hour
                        list << appointment
                    end
                end
            end   
            list
        end


end
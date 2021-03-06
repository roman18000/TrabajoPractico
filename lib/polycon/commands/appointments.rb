module Polycon
  module Commands
    module Appointments
      class Create < Dry::CLI::Command
        desc 'Create an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: true, desc: "Patient's name"
        option :surname, required: true, desc: "Patient's surname"
        option :phone, required: true, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" --name=Carlos --surname=Carlosi --phone=2213334567'
        ]

        def call(date:, professional:, name:, surname:, phone:, notes: nil)
          #warn "TODO: Implementar creación de un turno con fecha '#{date}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          begin
            print Polycon::Models::Appointments.add_appointment(date,professional,name,surname,phone,notes)
            puts " se creo correctamente"
          rescue => e
            puts e.message
          end
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show details for an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" # Shows information for the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:)
          #warn "TODO: Implementar detalles de un turno con fecha '#{date}' y profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          begin
            Polycon::Helpers::Utils.validete_date_format(date)
            d = Polycon::Helpers::Utils.create_date(date)
            puts Polycon::Models::Appointments.show_appointment(d,professional)
          rescue => e
            puts e.message
          end
        end
      end

      class Cancel < Dry::CLI::Command
        desc 'Cancel an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" # Cancels the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:)
          #warn "TODO: Implementar borrado de un turno con fecha '#{date}' y profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          begin
            Polycon::Models::Appointments.cancel_appointment(date, professional)
            puts "El turno se cancelo corectamente"
          rescue => e
            puts e.message
          end
        end
      end

      class CancelAll < Dry::CLI::Command
        desc 'Cancel all appointments for a professional'

        argument :professional, required: true, desc: 'Full name of the professional'

        example [
          '"Alma Estevez" # Cancels all appointments for professional Alma Estevez',
        ]

        def call(professional:)
          #warn "TODO: Implementar borrado de todos los turnos de la o el profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          begin
            Polycon::Models::Appointments.cancel_all_appointments(professional)
            puts "Se cancelaron todos los turnos para #{professional} con exito"
          rescue => e
            puts e.message
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List appointments for a professional, optionally filtered by a date'

        argument :professional, required: true, desc: 'Full name of the professional'
        option :date, required: false, desc: 'Date to filter appointments by (should be the day)'

        example [
          '"Alma Estevez" # Lists all appointments for Alma Estevez',
          '"Alma Estevez" --date="2021-09-16" # Lists appointments for Alma Estevez on the specified date'
        ]

        def call(professional:, date: nil)
          #warn "TODO: Implementar listado de turnos de la o el profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          begin
            if (date == nil)
              puts Polycon::Models::Appointments.list_appointments_professional(professional)
            else
              puts Polycon::Models::Appointments.list_appointments_professional_and_date(professional,date)
            end
          rescue => e 
            puts e.message
          end
        end
      end

      class Reschedule < Dry::CLI::Command
        desc 'Reschedule an appointment'

        argument :old_date, required: true, desc: 'Current date of the appointment'
        argument :new_date, required: true, desc: 'New date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" "2021-09-16 14:00" --professional="Alma Estevez" # Reschedules appointment on the first date for professional Alma Estevez to be now on the second date provided'
        ]

        def call(old_date:, new_date:, professional:)
          #warn "TODO: Implementar cambio de fecha de turno con fecha '#{old_date}' para que pase a ser '#{new_date}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          begin
            Polycon::Models::Appointments.reschedule_appointment(old_date, new_date, professional)
            puts "Se cambio el turno correctamente"
          rescue => e 
            puts e.message
          end
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit information for an appointments'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: false, desc: "Patient's name"
        option :surname, required: false, desc: "Patient's surname"
        option :phone, required: false, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" --name="New name" # Only changes the patient\'s name for the specified appointment. The rest of the information remains unchanged.',
          '"2021-09-16 13:00" --professional="Alma Estevez" --name="New name" --surname="New surname" # Changes the patient\'s name and surname for the specified appointment. The rest of the information remains unchanged.',
          '"2021-09-16 13:00" --professional="Alma Estevez" --notes="Some notes for the appointment" # Only changes the notes for the specified appointment. The rest of the information remains unchanged.',
        ]

        def call(date:, professional:, **options)
          #warn "TODO: Implementar modificación de un turno de la o el profesional '#{professional}' con fecha '#{date}', para cambiarle la siguiente información: #{options}.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          begin
            Polycon::Models::Appointments.edit_appointments(date, professional, **options)
            puts "Se edito correctamente"
          rescue => e 
            puts e.message
          end
        end
      end

      class ExportListDay < Dry::CLI::Command
        desc 'List appointments in a day, optionally filtered by a professional'

        argument :date, required: true, desc: 'Day'
        option :professional, required: false, desc: 'Full name of the professional'

        example [
          '"2021-09-16" #List appointments for that day',
          '"2021-09-16" --professional="Alma Estevez" #List appointments for that day for Alma Estevez '
        ]

        def call(date:, professional: nil)
          begin
            Polycon::Models::Appointments.export_list_appointments_for_day_with_professional(date, professional)
            puts "Se exporto la lista del dia correctamente"
          rescue => e 
            puts e.message
          end
        end
      end

      class ExportListWeek < Dry::CLI::Command
        desc 'List appointments in a week, optionally filtered by a professional'

        argument :date, required: true, desc: 'Day'
        option :professional, required: false, desc: 'Full name of the professional'

        example [
          '"2021-09-16" #List appointments for that week',
          '"2021-09-16" --professional="Alma Estevez" #List appointments for that week for Alma Estevez '
        ]

        def call(date:, professional: nil)
          begin
            Polycon::Models::Appointments.export_list_appointments_for_week_with_professional(date, professional)
            puts "Se exporto la lista de la semana correctamente"
          rescue => e 
            puts e.message
          end
        end
      end
      

    end
  end
end

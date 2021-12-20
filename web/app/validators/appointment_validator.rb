class AppointmentValidator < ActiveModel::Validator
  def validate(record)
    begin
      a = Appointment.find(record.id)
      if a.date != record.date 
        validate_date_not_repeat_for_professional(record)
      end
    rescue ActiveRecord::RecordNotFound    #Esta creando uno nuevo por que no encontro el id
      validate_date_higher_today(record)  
      validate_date_not_repeat_for_professional(record)
    end 
  end 

  def validate_date_higher_today(record)
    if record.date < DateTime.now
      record.errors.add :date, "Must be greater than today"
    end
  end

  def validate_date_not_repeat_for_professional(record)
    p = Professional.find(record.professional_id)
    if p.date_repeat(record.date)
      record.errors.add :date, "you can not repeat the time and day for a professional"
    end
  end

end
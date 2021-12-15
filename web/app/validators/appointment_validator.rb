class AppointmentValidator < ActiveModel::Validator
  def validate(record)
    validate_date_higher_today(record)  #valida que la fecha sea mayor a hoy
    validate_date_not_repeat_for_professional(record)
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
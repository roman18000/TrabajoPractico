class Appointment < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :professional


  validates :date, :name, :surname, :phone,  presence: true
  validates_with AppointmentValidator
  #validates :professional, presence: true
  #ejemplo para poner mensaje "validates :name, presence: { message: 'debe colocar un nombre'}"
  #despues en una consola por ejemplo cuando intento instanciar un objeto me da error y si miro
  #los errores con instancia.errors.full_messages salta el error

  def hour
    "#{self.date.hour}:00"
  end

  def to_s
    "Apellido: #{self.surname} Nombre: #{self.name} Telefono: #{self.phone} Notas: #{self.notes} Profesional: #{self.professional.name}"
  end

end

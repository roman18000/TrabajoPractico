class Appointment < ApplicationRecord
  belongs_to :professional

  validates :date, :name, :surname, :phone,  presence: true
  #validates :professional, presence: true
  #ejemplo para poner mensaje "validates :name, presence: { message: 'debe colocar un nombre'}"
  #despues en una consola por ejemplo cuando intento instanciar un objeto me da error y si miro
  #los errores con instancia.errors.full_messages salta el error
end

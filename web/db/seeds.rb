# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Aca cargo datos para prueba en la bd
#rails db:seed 

#User.create(email: 'admin@gmail.com', password: '123456')

#User.create(email: 'juan@gmail.com', password: '123456')
#cargar datos 


#Creacion de Usuarios y asignacion de roles --------------->
User.create(email: 'lector@mail.com', password: '123456')

as = User.create(email: 'asistente@mail.com', password: '123456')
as.assistant!

a = User.create(email: 'admin@mail.com', password: '123456')
a.admin!

#Creacion de Profesionales ------------------>

p1 = Professional.create(name: 'Juan Perez')
p2 = Professional.create(name: 'Pedro Alvarez')
p3 = Professional.create(name: 'Alma Estevez')

#Creacion de Turnos ------------------->

d1 = DateTime.parse("2021-12-27-16:00")
d2 = DateTime.parse("2021-12-30-13:00")
d3 = DateTime.parse("2022-01-08-14:00")

d4 = DateTime.parse("2021-12-30-13:00")
d5 = DateTime.parse("2022-01-14-08:00")

d6 = DateTime.parse("2022-02-22-10:00")


Appointment.create(date: d1, name:'Federico', surname:'Campot', phone: 22133, notes:'Fiebre', professional: p1)
Appointment.create(date: d2, name:'Carlos', surname:'Paz', phone: 2244, notes:'Dolor', professional: p1)
Appointment.create(date: d3, name:'Joaquin', surname:'Ferrai', phone: 2433, notes:'Fiebre', professional: p1)

Appointment.create(date: d4, name:'Santiago', surname:'Lopez', phone: 22133, notes:'Dolor', professional: p2)
Appointment.create(date: d5, name:'Agustina', surname:'Lopez', phone: 2253, notes:'Urgente', professional: p2)

Appointment.create(date: d5, name:'Fernanda', surname:'Paz', phone: 2563, professional: p3)
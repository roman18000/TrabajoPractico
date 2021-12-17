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


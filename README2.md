
Decisiones de diseño:  
La estructura ya dada por la cátedra fue modificada sutilmente, la parte del modelo está incluida en una carpeta llamada “models”, dentro de la carpeta lib. A su vez existe el módulo “Models” el cual tiene un archivo para cargar los autoloads.
Dentro de la carpeta models decidí implementar todos lo referido al modelo e incluso utilidades para las clases del modelo(validadores,etc).
Las clases implementadas son “professionals y appoinments” que ambas comparten un estructura similar, para la funcionalidades pedidas(create, delete, list, etc) utilizan métodos de clase los cuales ,instancian, buscan o borran según sea necesario.
En el apartado de “utils” están los validadores necesarios para poder guardar, leer y modificar la información.
La estructura en todos los métodos son similares, las validaciones se hacen en utils, donde son llamadas desde el modelo. Se maneja la mayoría con excepciones que son lanzadas en caso de error por las validaciones hechas

Rails:
La creacion de rails se realizo en la carpeta web, a partir de ahi se trato de seguir todas las convenciones indicacas por rails para crear la parte web del proyecto. Se crearon las clases, controladores y viste de appointments y professionals, todo mediante el generate que ofrece rails.
En caso de las validaciones personalizadas se creo una carpeta para las mismas.
La pagina, despues de haber iniciado sesion, comienza mostrando un listado de los profesionales en el sistema, donde se puede tanto crear, modificar, ver y borrar ademas de poder entrar a los turnos de cada uno.
A los turnos solo se puede ingresar a travez de los profesionales, no se va a poder de otra manera.
En el listado de turnos se puede tambien crear, modificar, ver y borrar. Todo esto como en la parte de profesional, verificado con validaciones.
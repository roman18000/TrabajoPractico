
Decisiones de diseño:  
La estructura ya dada por la cátedra fue modificada sutilmente, la parte del modelo está incluida en una carpeta llamada “models”, dentro de la carpeta lib. A su vez existe el módulo “Models” el cual tiene un archivo para cargar los autoloads.
Dentro de la carpeta models se decidió implementar todos lo referido al modelo e incluso utilidades para las clases del modelo(validadores,etc).
Las clases implementadas son “professionals y appoinments” que ambas comparten un estructura similar, para la funcionalidades pedidas(create, delete, list, etc) utilizan métodos de clase los cuales ,instancian, buscan o borran según sea necesario.
En el apartado de “utils” están los validadores necesarios para poder guardar, leer y modificar la información.
La estructura en todos los métodos son similares, las validaciones se hacen en utils, donde son llamadas desde el modelo. Se maneja la mayoría con excepciones que son lanzadas en caso de error por las validaciones hechas.
Para la exportación se creo en la carpeta llamada helpers 'exports.rb' donde utiliza las gemas 'prawn' y 'prawn-table'. Se puede exportar de dos formas, un día en especifico o una semana, a su vez se puede decidir en ambos casos si se exportara para un profesional o para todos los profesionales del sistema.
Esta exportación de .pdf se guardara en la carpeta personal del usuario con el nombre de 'polycon_files'.
Como resguardado de datos se utiliza el disco donde se corre el programa, en una carpeta que se genera en el primer agregado de un profesional llamada 'polycon', ubicada en la carpeta personal del usuario. 

Rails:
La creacion de rails se realizo en la carpeta web, a partir de ahi se trato de seguir todas las convenciones indicacas por rails para crear la parte web del proyecto. Se crearon las clases, controladores y viste de appointments y professionals, todo mediante el generate que ofrece rails.
En caso de las validaciones personalizadas se creo una carpeta para las mismas.
La pagina, despues de haber iniciado sesion, comienza mostrando un listado de los profesionales en el sistema, donde se puede tanto crear, modificar, ver y borrar ademas de poder entrar a los turnos de cada uno.
A los turnos solo se puede ingresar a travez de los profesionales, no se va a poder de otra manera.
En el listado de turnos se puede tambien crear, modificar, ver y borrar. Todo esto como en la parte de profesional, verificado con validaciones.
Para la creación de los turnos las validaciones son, no se puede crear un turno que su fecha y hora no sean mayor al momento de la realización, ademas no coincidan con otro turno para un mismo profesional. Al momento de seleccionar el tiempo del turno solo se va a poder seleccionar la hora, ya que se supone que cada turno dura una hora, por lo tanto no se pueden ingresar los minutos.
Los usuarios tienen email y contraseña, lo primero en la pagina es el inicio de sesión. Solo se diseño el iniciar sesión y cerrar sesión, no se puede registrar a través de la pagina. A su vez estos usuarios pueden tener distintos roles:
• Reader o lector: Como el nombre lo indican solo podrán hacer lecturas en el sistema, tanto en la parte de profesionales como en la de turnos. No podrá realizar cambios en los datos del sistemas (agregar, modificar o borrar).
• Assistant o asistente: El asistente podrá gestionar la parte de turnos, tanto creación, modificación y borrado. No podrá realizar cambios en la parte de profesionales, (creación, modificación o borrado).
• Admin o administrador: Podrá hacer cualquier operación en sistema, en cualquier parte.
Estas funcionalidades fueron llevadas a cabo con la ayuda de distintas gemas, para el caso de la autenticación se utilizo 'devise'. Para el manejo de roles y permisos se utilizo 'cancancan'.
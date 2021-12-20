Decisiones de diseño:  
La estructura ya dada por la cátedra fue modificada sutilmente, la parte del modelo está incluida en una carpeta llamada “models”, dentro de la carpeta lib. A su vez existe el módulo “Models” el cual tiene un archivo para cargar los autoloads.
Dentro de la carpeta models se decidió implementar todos lo referido al modelo. Las clases implementadas son “professionals y appoinments” que ambas comparten un estructura similar, para la funcionalidades pedidas(create, delete, list, etc) utilizan métodos de clase los cuales ,instancian, buscan o borran según sea necesario.
En el apartado de “utils” en la carpeta 'helpers' están los validadores necesarios para poder guardar, leer y modificar la información.
La estructura en todos los métodos son similares, las validaciones se hacen en utils, donde son llamadas desde el modelo. Se maneja la mayoría con excepciones que son lanzadas en caso de error por las validaciones hechas.
Para la exportación se creó en la carpeta llamada helpers 'exports.rb' donde utiliza las gemas 'prawn' y 'prawn-table'. Se puede exportar de dos formas, un día en específico o una semana, a su vez se puede decidir en ambos casos si se exportará para un profesional o para todos los profesionales del sistema.
Esta exportación de .pdf se guardará en la carpeta personal del usuario con el nombre de 'polycon_files'.
Se exporta un grilla con los horarios de 8 de la mañana a 17 de la tarde, por un tema de facilidad de lectura del pdf, no es una restricción.
Cómo resguardado de datos se utiliza el disco donde se corre el programa, en una carpeta que se genera en el primer agregado de un profesional llamada 'polycon', ubicada en la carpeta personal del usuario.

Rails:
La creación de rails se realizó en la carpeta web, a partir de ahí se trató de seguir todas las convenciones indicadas por rails para crear la parte web del proyecto. Se crearon las clases, controladores y vistas de appointments y professionals, todo mediante el generate que ofrece rails.
En caso de las validaciones personalizadas se creó una carpeta para las mismas.
La página, después de haber iniciado sesión, comienza mostrando un listado de los profesionales en el sistema, donde se puede tanto crear, modificar, ver y borrar además de poder entrar a los turnos de cada uno.
A los turnos solo se puede ingresar a través de los profesionales, no se va a poder de otra manera.
En el listado de turnos se puede también crear, modificar, ver y borrar. Todo esto como en la parte de profesional, verificado con validaciones.
Para la creación de los turnos las validaciones son, no se puede crear un turno que su fecha y hora no sean mayor al momento de la realización, además que no coincidan con otro turno para un mismo profesional. Al momento de seleccionar el tiempo del turno solo se va a poder seleccionar la hora, ya que se supone que cada turno dura una hora, por lo tanto no se pueden ingresar los minutos.
Para la modificación las validaciones van a ser un poco distintas a la de creación, se valida que la fecha y hora modificada no coincida con una el sistema para un mismo profesional, pero no se va a evaluar si es mayor al día de la modificación, ya que si se desea mantener un registro de los turnos y se corrige alguna fecha de un turno antiguo por otro fecha antigua se va poder ingresar un fecha menor a la actual.
Los usuarios tienen email y contraseña, lo primero en la página es el inicio de sesión. Sólo se diseñó el iniciar sesión y cerrar sesión, no se puede registrar a través de la página. A su vez estos usuarios pueden tener distintos roles:
• Reader o lector: Como el nombre lo indican sólo podrán hacer lecturas en el sistema, tanto en la parte de profesionales como en la de turnos. No podrá realizar cambios en los datos del sistemas (agregar, modificar o borrar).
• Assistant o asistente: El asistente podrá gestionar la parte de turnos, tanto creación, modificación y borrado. No podrá realizar cambios en la parte de profesionales, (creación, modificación o borrado).
• Admin o administrador: Podrá hacer cualquier operación en sistema, en cualquier parte.
Estas funcionalidades fueron llevadas a cabo con la ayuda de distintas gemas, para el caso de la autenticación se utilizó 'devise'. Para el manejo de roles y permisos se utilizó 'cancancan'.
Para la exportación de las grillas en formato pdf, se volvió a utilizar, como en el tp2, la gema 'prawn' y 'prawn-table'. El controlador seleccionado para esta acción fue el de profesionales, ya que corresponde a los turnos de un o varios profesionales, por lo tanto está en la parte del mismo. Se creó un formulario en el cual se ingresa las decisiones de exportar el archivo, las mismas son; la fecha de día o semana a exportar, si la grilla debe ser semanal o diaria y algún profesional en específico o todos.
Dependiendo de las decisiones tomadas se descarga en archivo pdf con la grilla cargada.
En la carpeta export en app es donde esta el archivo 'export_file' que es el encargado de la creación del pdf y la utilización de las gemas mencionadas, estos métodos son utilizados en el controlador.
Se exporta un grilla con los horarios de 8 de la mañana a 17 de la tarde, por un tema de facilidad de lectura del pdf, no es una restricción.

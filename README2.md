
Decisiones de diseño:  
La estructura ya dada por la cátedra fue modificada sutilmente, la parte del modelo está incluida en una carpeta llamada “models”, dentro de la carpeta lib. A su vez existe el módulo “Models” el cual tiene un archivo para cargar los autoloads.
Dentro de la carpeta models decidí implementar todos lo referido al modelo e incluso utilidades para las clases del modelo(validadores,etc).
Las clases implementadas son “professionals y appoinments” que ambas comparten un estructura similar, para la funcionalidades pedidas(create, delete, list, etc) utilizan métodos de clase los cuales ,instancian, buscan o borran según sea necesario.
En el apartado de “utils” están los validadores necesarios para poder guardar, leer y modificar la información.
La estructura en todos los métodos son similares, las validaciones se hacen en utils, donde son llamadas desde el modelo. Se maneja la mayoría con excepciones que son lanzadas en caso de error por las validaciones hechas.
Para la exportación de pds solicitados en el tp2, se utilizo dos gemas, "prawn" y "prawn-table", tanto para la grilla de la semana como la de un día.
Se movió utils.rb y se creo exports.rb, en la carpeta helpers, ya que no pertenecen al modelo y solo se encargan de validaciones o creación de tablas, fechas, etc.
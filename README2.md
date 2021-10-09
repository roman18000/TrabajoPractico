Puede suceder que para poder utilizar la aplicación es necesario que se ejecute en modo root “chmod 777 /home/polycon” para que la app tenga permisos de creación, lectura, etc, en ese directorio.

Decisiones de diseño:  
La estructura ya dada por la cátedra fue modificada sutilmente, la parte del modelo está incluida en una carpeta llamada “models”, dentro de la carpeta lib. A su vez existe el módulo “Models” el cual tiene un archivo para cargar los autoloads.
Dentro de la carpeta models decidí implementar todos lo referido al modelo e incluso utilidades para las clases del modelo(validadores,etc).
Las clases implementadas son “professionals y appoinments” que ambas comparten un estructura similar, para la funcionalidades pedidas(create, delete, list, etc) utilizan métodos de clase los cuales ,instancian, buscan o borran según sea necesario.
En el apartado de “utils” están los validadores necesarios para poder guardar, leer y modificar la información.

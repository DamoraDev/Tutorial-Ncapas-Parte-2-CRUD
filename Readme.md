## **Proyecto Login NCapas**

**1.- Login Basico en 3 capas**
    -Formulario ( Vista)    
    -Clases          (Modelo)
    -Logica          (Controlador/ Negocio)
El funcionamiento es muy similar a los modelos MVC.

**2.- Funcionamiento**
    -El formulario usa la unidad logica.pas ( Datos de login: admin // 1234)
    -Aqui declaramos todos los procedimientos y funciones necesarios para la       aplicación.
    -La unidad logica.pas usa la unidad uClassUsuario.pas
    -Aqui declaramos la clase, por norma cada unidad debe contener una clase.En         situaciones especiales, se pueden tener varias clases en una misma unidad, pero         como antes he mencionado no es lo recomentable.

**3.- Mejoras**

    - Crear una funcion para encriptar la contraseña y verificarla con la existente en la         base de datos
    - Añadir un token o un dato único a la encriptacion para evitar la fuerza bruta:         ejemplo: añadir 'F01B:'

        a nuestra cadena encriptada. Tambien podemos encriptar el usuario y usar parte         de la cadena encriptada uniendola con la cadena de la contraseña:
            Si la contraseña es de 44 digitos, podemos añadir 6 de parte de la cadena del             usuario y asi obtendriamos una cadena de 50 digitos, que haria mas complejo el             uso de fuerza bruta.
    -Para encriptar se pueden utilizar MD5 o SHA256, este último es el mas         recomendable.
    -Tambien se puede añadir una función que capture los roles devolviendo el rol para         que cada Form sepa  que rol tiene el usuario y habilitar o deshabilitar opciones.
    -Auditoria: se puede implementar un registro de las acciones: quien entra, a que         hora, que dia, que rol tiene, que cosas ha tocado... 
    -Para todo lo anterior podemos crear una Clase auditoria y una Clase Rol:    
                

                **Clase Auditoria:**
                Registro_Fecha:Tdate;
                Registro_Hora:TTime; 
                // se puede usar Registro_Fecha en formato Time Stamp o DateTime
                Registro_Usuario:string;
                Registro_Rol:string;
                Registro_Accion:string;

                **Clase Rol:**
                Tipo_Rol:integer; //se puede byte, ya que vamos a tener pocos roles
                Descripcion_Rol:String;

**4.- Objetivos planificados del proyecto Ejemplo de Login N capas:**
            -Sistema completo de Login con base de datos ADO utilizando MSAcces.
            -Encriptacion segura con SHA256+cadena de x digitos capturados del usuario.
            -Control de Roles Mediante el uso de una función ColtrolUsuario
            -Un segundo formulario con menus controlados por la funcion ControlUsuario.
            -Sistema de Cambio de contraseña y gestión de usuarios basandose en el rol                 administrador.
            -Uso de clases dentro de clases.
            -Sistema de control de errores usando una función que nos marque los campos                 con errores.
            -Sistema de limpieza de los campos: dejar el form en su estado original

**5.- Que puedes aprender de este proyecto:**
            - Creacion de clases con sus respectivos contrustores y destructores
            - Manejo de controles en tiempo de ejecución
            - Encriptacion de cadenas de texto
            - Implementar mejoras en un sistema de encriptación para evitar la                 desencriptación   por fuerza bruta.
            - Manejo de información entre formularios.
            - Uso de unidades
            - Manejo de cadenas de texto
            - Uso de SQL para añadir usuarios, modificar contraseñas etc..
            - Manejo de eventos de controles

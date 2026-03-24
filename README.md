# Evaluación Flutter
Proyecto en Flutter para la evaluación.

# Requisitos previos
Antes de empezar, instala lo siguiente en tu dispositivo:
- Git: para clonar el repositorio.
- Visual Studio Code (VS Code): editor de código recomendado.
- Node.js (última versión estable): para ejecutar el backend.
- Flutter SDK junto con Dart SDK: para compilar y correr el frontend.
- Base de datos MySQL.
- XAMPP.

# Clonar repositorio 
Abrir el Visual Studio Code e ingresar a la terminal (ctrl + ñ)
el siguiente comando: 
git clone https://github.com/TU_USUARIO/TU_REPO.git
cd TU_REPO

# Base de datos
En la carpeta my_project hay una carpeta llamada "database", ahi contiene toda la base de datos
en MySQL, simplemente copiar y pegar todo los datos, seguidamente ingresamos a XAMPP 
y creamos una base de datos llamada "api-crud", e ingresamos los datos.


# Flutter
Abrir la capeta (flutter) que esta dentro de la carpeta my_project en la terminal
con el comando "cd", seguidamente ingrese este comando: "flutter pub get",
esto sirve para descargar e instalar todas las dependencias de flutter/dart.
Para que la aplicacion corra, despues de hacer todos los pasos, ingresamos el
comando "flutter run" y seleccionamos la opcion de tu preferencias (La opcion de Chrome es la
recomendada).

# Node.js
En otra ventana volvemos a la carpeta my_project e ingresamos a la carpeta "api",
seguidamente descargamos las dependencias con el comando: "npm install".
Dentro de la misma carpeta hay un archivo llamado .env, el cual debes seguir las
siguientes variables:

# Explicación de las variables
- **SERVER_PORT** = puerto en el que se ejecutará el servidor (por defecto 3000).
- **DB_NAME** = nombre de la base de datos que usará la API (api-crud).  
- **DB_HOST** = dirección del servidor de base de datos (en este caso 127.0.0.1).  
- **DB_USER** = usuario de la base de datos (ejemplo: root).  
- **DB_PASSWORD** = contraseña del usuario de la base de datos.
- **DB_PORT** = -  define el puerto de conexión de la base de datos (puerto de MySQL: '3306')
- **DB_DIALECT** = indica el tipo de base de datos que se esta utilizando (en este caso: 'mysql')
- **JWT_SECRET** = - es la clave secreta para firmar y validar tokens JWT en el sistema de autenticación
  ("jwt_secret_key"). 
 
Ponemos a correr el servidor con el siguiente comando: "npm run dev", seguidamente nos tiene
que aparecer un puerto 3000.


# Dependencias Node.js
estas van a hacer las dependencias que vamos a necesitar:
- express
- cors
- dotenv
- bcrypt / bcryptjs
- jsonwebtoken
- morgan

Como sugerencia, si hay problemas con las dependencias usamos el siguiente
comando en nuestra carpeta de "api": npm install (seguidamente del nombre de la dependencia).

# Dependencias flutter
En el archivo pubspec.yaml en la carpeta de flutter, en la parte donde dice "dependencies", agregamos
la dependencia "http: ^1.2.0", la dependencia tiene que quedar asi: 

dependencies:
  flutter:
    sdk: flutter
  dio: ^5.4.0
  cached_network_image: ^3.3.0

acto seguido ingresamos en la terminal el comando: "flutter pub get".


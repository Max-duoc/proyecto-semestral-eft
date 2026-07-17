Proyecto Semestral — Sistema de Ventas y Despachos
Sistema de gestión de ventas y despachos compuesto por dos APIs REST en Spring Boot (Ventas y Despachos), un frontend en React (Vite), y una base de datos MySQL. El proyecto está completamente dockerizado y su despliegue a producción está automatizado con GitHub Actions hacia AWS (ECS Fargate).
Stack tecnológico

Backend Despachos: Spring Boot 3, Java 21, Maven
Backend Ventas: Spring Boot 3, Java 21, Maven
Frontend: React + Vite, servido con Nginx
Base de datos: MySQL 8.0
Contenedores: Docker y Docker Compose
CI/CD: GitHub Actions
Cloud: AWS (ECR, ECS Fargate, RDS, Application Load Balancer, CloudWatch)

Arquitectura
El Application Load Balancer recibe todo el tráfico y lo enruta según el path: las rutas que empiezan con /api/v1/despachos van al servicio de Despachos, las que empiezan con /api/v1/ventas van al servicio de Ventas, y todo lo demás cae al frontend. Ambos backends se conectan a la misma instancia de RDS MySQL, pero cada uno usa su propia base de datos y su propio usuario, sin acceso cruzado entre ellos.
Cómo correr el proyecto en local
Necesitas tener Docker y Docker Compose instalados.

Clona el repositorio.
Copia el archivo .env.example a .env y completa las variables con tus propios valores (contraseñas de base de datos, nombres de las bases, etc.).
Desde la raíz del proyecto, ejecuta: docker-compose up --build
Abre http://localhost:3000 en tu navegador.

El backend de Ventas queda disponible en el puerto 8080 y el de Despachos en el 8081, ambos bajo el prefijo /api/v1/.
Variables de entorno
Todas las variables sensibles (contraseñas y nombres de bases de datos) se manejan a través de un archivo .env que no se sube al repositorio. El archivo .env.example muestra qué variables se necesitan, sin valores reales.
CI/CD
El pipeline definido en .github/workflows/deploy.yml se ejecuta automáticamente con cada push a la rama main. Primero compila y corre las pruebas de ambos backends contra una base de datos MySQL temporal, después construye las tres imágenes Docker (dos backends y el frontend) y las publica en Amazon ECR, y finalmente fuerza a los servicios de ECS a desplegar las versiones nuevas. Las credenciales de AWS se gestionan como secretos de GitHub, nunca quedan expuestas en el código.
Seguridad
Los backends corren dentro de sus contenedores con un usuario sin privilegios de administrador, no como root. Las imágenes están basadas en Alpine para mantenerlas livianas. Cada backend tiene su propio usuario de base de datos con acceso limitado únicamente a su propia base, y la base de datos en AWS solo acepta conexiones desde los servicios de ECS, no desde internet en general.
Observabilidad
Los logs de ambos backends y del frontend se envían automáticamente a CloudWatch, donde también se pueden revisar métricas básicas de uso de CPU y memoria de cada servicio desplegado.
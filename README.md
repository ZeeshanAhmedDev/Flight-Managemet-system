# Flight Management System
The Flutter Flight management system web application is developed for a specific purpose. This application is docarized to ensure ease of development and scalability. Below you will find all the information and instructions regarding  
building and deploying the Dockerized application. using different useful commands of Docker.

## Building the Application

Step 1: Clone the Repository
  Clone the repository into your Integrated Development Environment (IDE). You can use any IDE that supports Flutter, such as Visual Studio Code or IntelliJ IDEA and Android Studio.       please remeber to install the appropriate flutter which is Dart 3.3.0 or 3.19.1 flutter. And don't forget to install dart and flutter plugin in specific IDE.

Step 2: Docker Build
  1. Navigate to the root directory of your Flutter web project.
  2. Ensure that the "Dockerfile" and "docker-compose.yaml" are present in the root directory.
  3. Run any of the following command in the terminal to build the Docker image:
     "docker build -t flutter_web_app ."
     "docker-compose up --build"
  4. Once the build process is complete, you will have a Docker image named "flutter_web_app"   

## Deploying the Application

Step 1: Running the Docker Container
  1. Open a command prompt or terminal.
  2. Go to the directory containing the Docker image.
  3. To launch the Docker container, type the following command:
     "docker run -d -p 8080:80 flutter_web_app"
  4. Ensure that port 8080 is available on your machine, as the application will be served on this port.

Step 2: Accessing the Application

1. Open your web browser.
2. Go to the URL: "http://localhost:8080/".
3. The application should start running in your browser.

## Application Architecture:
The application is built using and served using Flutter's web support.

Docker Container:
  The application is built using Fullter's web support
  The Docker container runs Nginx and serves the application on port 8080.

Flutter Web:
  The frontend of the application is developed using Flutter and compiled web standards (HTML, CSS, and JavaScript).
  The application is responsive and can be accessed from any modern web browser.
  
This architecture allows for a portable, scalable, and easily deployable web application.




pipeline {
    agent any

    environment {
        IMAGE_NAME = "hugo-blog-prod"
        CONTAINER_NAME = "hugo-site-prod"
    }

    stages {
        stage('Nettoyage') {
            steps {
                echo "Nettoyage"
                // Supprime le conteneur précédent s'il existe pour libérer le port
                // sh "docker rm -f ${CONTAINER_NAME} || true"
            }
        }

        stage('Build Image') {
            steps {
                echo "Build de l'image Docker"
                // Build l'image à partir de ton Dockerfile (multi-stage)
                // sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Deploy') {
            steps {
                echo "Déploiement du site"
                // Lance le site sur le port 8081 (pour ne pas gêner Jenkins sur le 8080)
                // sh "docker run -d --name ${CONTAINER_NAME} -p 8081:80 ${IMAGE_NAME}"
                // echo "Site déployé sur http://localhost:8081"
            }
        }
    }
}
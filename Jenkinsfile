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
                docker rm -f ${CONTAINER_NAME} || true
            }
        }

        stage('Build Image') {
            steps {
                echo "Build de l'image Docker"
                docker build -t ${IMAGE_NAME} .
            }
        }

        stage('Deploy') {
            steps {
                echo "Déploiement du site"
                docker run -d --name ${CONTAINER_NAME} -p 8081:80 ${IMAGE_NAME}
                echo "Site déployé sur http://localhost:8081"
            }
        }
    }
}
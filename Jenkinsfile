pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dckr_pat_mTH0YpM3VL8KoK_WzvyjEr3g4C4') // ID kredensial Docker Hub di Jenkins
        IMAGE_NAME = "akramdaffa/ci-cdproject" // Ganti dengan nama Docker Hub Anda
    }
    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                bat """
                docker build -t %IMAGE_NAME%:%BUILD_NUMBER% .
                docker tag %IMAGE_NAME%:%BUILD_NUMBER% %IMAGE_NAME%:latest
                """
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        bat "docker push %IMAGE_NAME%:latest"
                        bat "docker push %IMAGE_NAME%:%BUILD_NUMBER%"
                    }
                }
            }
        }
        stage('Deploy Application') {
            steps {
                bat """
                docker stop ci-cdproject || exit 0
                docker rm ci-cdproject || exit 0
                docker run -d --name ci-cdproject -p 8089:3000 %IMAGE_NAME%:latest
                """
            }
        }
    }
}


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
                sh """
                docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} .
                docker tag ${IMAGE_NAME}:${env.BUILD_NUMBER} ${IMAGE_NAME}:latest
                """
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        sh "docker push ${IMAGE_NAME}:latest"
                        sh "docker push ${IMAGE_NAME}:${env.BUILD_NUMBER}"
                    }
                }
            }
        }
        stage('Deploy Application') {
            steps {
                sh """
                docker stop ci-cdproject || true
                docker rm ci-cdproject || true
                docker run -d --name ci-cdproject -p 8089:3000 ${IMAGE_NAME}:latest
                """
            }
        }
    }
}

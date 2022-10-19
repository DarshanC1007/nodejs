pipeline {
    agent any 
    environment {
        AWS_ACCOUNT_ID="878004044611"
        AWS_DEFAULT_REGION="ap-south-1" 
        IMAGE_REPO_NAME="my-react-app"
        IMAGE_TAG="BUILD_NUMBER"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
        stages {
            stage ('git clone from repo'){
            steps{
                    git branch: 'main', credentialsId: 'GIT_HUB_CREDENTIALS', url: 'https://github.com/DarshanC1007/nodejs.git'
                }
            }
            stage ('Build Docker Image') {
            steps {
                sh 'docker build -t my-react-app:${BUILD_NUMBER} .'
            }
        }
            stage ('Login to AWS and push to ECR') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS_CREDENTIALS',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) 
                {
                    
                    sh 'aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com'
                    sh 'docker tag ${IMAGE_REPO_NAME}:${BUILD_NUMBER} ${REPOSITORY_URI}:${BUILD_NUMBER}'
                    sh 'docker push ${REPOSITORY_URI}:${BUILD_NUMBER}'
                }
                
            }
            }
        }
}
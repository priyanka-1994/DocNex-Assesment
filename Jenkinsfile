pipeline{
    tools{
        jdk 'java 11'
        maven 'maven 3'
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('Docker-Creds')
    }
    agent any
    options{
        buildDiscarder logRotator(artifactDaysToKeepStr:'' , artifactNumToKeepStr: '' , daysToKeepStr: '' , numToKeepStr: '3')
        timeout(10)
    }
    stages{
        stage('Cloning Git') {
            steps{
                cleanWs()
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/priyanka-1994/Deployment-CICD.git']])
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: false, reportDir: '', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                
            }   
            }
        stage('Build docker image'){
            steps{
                sh 'docker image build -t prikale/$JOB_NAME:v1.$BUILD_ID .'
             }
           }
        stage('Login into docker'){
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
               }
        }
        stage('Push docker image'){
            steps{
                sh 'docker image push prikale/$JOB_NAME:v1.$BUILD_ID'

            }
        }
        stage('Docker run Container'){
           steps{
              sh 'docker run -it -d --name myjenkinsapp -p 3000:80  prikale/$JOB_NAME:v1.$BUILD_ID'
               }
           }
        }
}

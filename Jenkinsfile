pipeline {
    agent any

    environment{
        def branch = "CICD"
        def nama_repository = "origin"
        def directory = "~/dumbmerch-fe"
        def credential = 'bhq'
        def server = 'bhq@10.84.198.151'
        def docker_image = 'naninanides/dumbmerch-fe-cicd'
        def nama_container = 'backend'
    }

    options {
        disableConcurrentBuilds()
        timeout(time: 30, unit: 'MINUTES')
    }

    stages {

        stage('Notif nih BOS') {
            steps {
                discordSend description: 'Proses sedang berjalan', footer: '', image: '', link: '', result: '', scmWebUrl: '', thumbnail: '', title: 'Proses CICD', webhookURL: 'https://discord.com/api/webhooks/1080451544039825439/j5kNTYdbxvkbcZlNBdITE5JXXZIfjOI0qbm7lZklz1YFQsGza2VSJC1onRAhg4oVzUEM'
            }
        }

        stage('pull repository dari github ') {
            steps {
                sshagent([credential]){
                    sh"""
                    ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    git pull ${nama_repository} ${branch}
                    exit
                    EOF"""
                }
            }
        }

        stage('docker compose down') {
            steps {
                sshagent([credential]){
                    sh"""
                    ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker compose down
                    exit
                    EOF"""
                }
            }
        }

        stage('build image frontend') {
            steps {
                sshagent([credential]){
                    sh"""ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker build -t ${docker_image}:latest .
                    exit
                    EOF"""
                }
            }
        }

        stage('jalankan docker compose') {
            steps {
                sshagent([credential]){
                    sh"""ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker compose up -d
                    exit
                    EOF
                    """
                }
            }
        }
        
        stage('push image ke dockerhub') {
            steps {
                sshagent([credential]){
                    sh"""
                    ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker image push ${docker_image}:latest
                    exit
                    EOF"""

                }
            }
        }
        
        stage('test frontend') {
            steps {
                sshagent([credential]){
                    sh"""ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker run --rm ${docker_image}:latest npm run test
                    exit
                    EOF"""
                }
           }
      }
}
    }
    post {

        aborted {
            discordSend description: 'Proses berjalan di cancel', footer: '', image: '', link: '', result: '', scmWebUrl: '', thumbnail: '', title: 'Proses CICD', webhookURL: 'https://discord.com/api/webhooks/1080451544039825439/j5kNTYdbxvkbcZlNBdITE5JXXZIfjOI0qbm7lZklz1YFQsGza2VSJC1onRAhg4oVzUEM'
        }
        failure {
            discordSend description: 'Proses berjalan gagal', footer: '', image: '', link: '', result: '', scmWebUrl: '', thumbnail: '', title: 'Proses CICD', webhookURL: 'https://discord.com/api/webhooks/1080451544039825439/j5kNTYdbxvkbcZlNBdITE5JXXZIfjOI0qbm7lZklz1YFQsGza2VSJC1onRAhg4oVzUEM'
        }

        success {
            discordSend description: 'Proses berjalan berhasil', footer: '', image: '', link: '', result: '', scmWebUrl: '', thumbnail: '', title: 'Proses CICD', webhookURL: 'https://discord.com/api/webhooks/1080451544039825439/j5kNTYdbxvkbcZlNBdITE5JXXZIfjOI0qbm7lZklz1YFQsGza2VSJC1onRAhg4oVzUEM'
        }
        
    }
    
}    

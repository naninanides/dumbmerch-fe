My Drive
pipeline {
    agent any

    environment{
        def branch = "Production"
        def nama_repository = "origin"
        def directory = "~/dumbmerch-fe"
        def credential = 'bhq'
        def server = 'bhq@10.84.198.151'
        def docker_image = 'naninanides/dumbmerch-fe-production'
        def nama_container = 'frontend'
    }

    options {
        disableConcurrentBuilds()
        timeout(time: 30, unit: 'MINUTES')
    }

    stages {

        stage('Notif nih BOS') {
            steps {
                discordSend description: '', footer: '', image: '', link: '', result: '', scmWebUrl: '', thumbnail: '', title: 'Mulai jalan nih ', webhookURL: 'https://discord.com/api/webhooks/1073903280893202502/FwVTY2tdIp9qekgj3qLn-ta-PuBst9FRg3lqmqFyu0yG_3dYFs5mB7SRCVBFiQACf4ua'
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
    }
    post {

        aborted {
            discordSend description: 'kok di gagalin', footer: '', image: '', link: '', result: '', scmWebUrl: '', thumbnail: '', title: 'proses yang berjalan', webhookURL: 'https://discord.com/api/webhooks/1073903280893202502/FwVTY2tdIp9qekgj3qLn-ta-PuBst9FRg3lqmqFyu0yG_3dYFs5mB7SRCVBFiQACf4ua'
        }
        failure {
            discordSend description: 'gagal nih bosss', footer: '', image: '', link: '', result: '', scmWebUrl: '', thumbnail: '', title: 'proses yang berjalan', webhookURL: 'https://discord.com/api/webhooks/1073903280893202502/FwVTY2tdIp9qekgj3qLn-ta-PuBst9FRg3lqmqFyu0yG_3dYFs5mB7SRCVBFiQACf4ua'
        }

        success {
            discordSend description: 'berhasil nih bos', footer: '', image: '', link: '', result: '', scmWebUrl: '', thumbnail: '', title: 'proses yang berjalan', webhookURL: 'https://discord.com/api/webhooks/1073903280893202502/FwVTY2tdIp9qekgj3qLn-ta-PuBst9FRg3lqmqFyu0yG_3dYFs5mB7SRCVBFiQACf4ua'
        }
        
    }
}

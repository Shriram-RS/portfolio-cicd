pipeline {
    agent any

    stages {
        stage('Test SSH Connection') {
            steps {
                sshagent(['gcp-ssh']) {
                    sh 'ssh -o StrictHostKeyChecking=no shriram@34.127.22.0 whoami'
                }
            }
        }
    }
}

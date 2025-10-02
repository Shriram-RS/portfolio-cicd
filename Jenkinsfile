pipeline {
    agent any

    stages {
        stage('Terraform Init & Plan') {
            steps {
                sh '''
                    ssh -i /home/jenkins/.ssh/id_rsa -o StrictHostKeyChecking=no shriram@34.127.22.0 \
                    "cd ~/terraform-gcp-vm && terraform init && terraform plan"
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                    ssh -i /home/jenkins/.ssh/id_rsa -o StrictHostKeyChecking=no shriram@34.127.22.0 \
                    "cd ~/terraform-gcp-vm && terraform apply -auto-approve"
                '''
            }
        }

        stage('Ansible Deploy') {
            steps {
                sh '''
                    ssh -i /home/jenkins/.ssh/id_rsa -o StrictHostKeyChecking=no shriram@34.127.22.0 \
                    "cd ~/terraform-gcp-vm && ansible-playbook -i hosts.ini deploy.yml"
                '''
            }
        }
    }

    post {
        success {
            echo 'Deployment finished successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

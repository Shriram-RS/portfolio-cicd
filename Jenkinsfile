pipeline {
    agent any

    stages {
        stage('Terraform Init & Plan') {
            steps {
                sshagent(['gcp-ssh']) {
                    sh '''
                        cd ~/terraform-gcp-vm
                        terraform init
                        terraform plan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sshagent(['gcp-ssh']) {
                    sh '''
                        cd ~/terraform-gcp-vm
                        terraform apply -auto-approve
                    '''
                }
            }
        }

        stage('Ansible Deploy') {
            steps {
                sshagent(['gcp-ssh']) {
                    sh '''
                        cd ~/terraform-gcp-vm
                        ansible-playbook -i hosts.ini deploy.yml
                    '''
                }
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

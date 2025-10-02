pipeline {
    agent any

    environment {
        GCP_VM_USER = 'shriram'
        GCP_VM_IP   = '34.127.22.0'
        TERRAFORM_DIR = '~/terraform-gcp-vm'
        ANSIBLE_DIR   = '~/ansible'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git(
                    url: 'https://github.com/Shriram-RS/portfolio-cicd.git',
                    branch: 'main',
                    credentialsId: 'github-creds'
                )
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                sshagent(['gcp-ssh']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${GCP_VM_USER}@${GCP_VM_IP} \\
                        "cd ${TERRAFORM_DIR} && terraform init && terraform plan"
                    """
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                sshagent(['gcp-ssh']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${GCP_VM_USER}@${GCP_VM_IP} \\
                        "cd ${TERRAFORM_DIR} && terraform apply -auto-approve"
                    """
                }
            }
        }

        stage('Ansible Deploy') {
            steps {
                sshagent(['gcp-ssh']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${GCP_VM_USER}@${GCP_VM_IP} \\
                        "cd ${ANSIBLE_DIR} && ansible-playbook deploy.yml -i inventory"
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}

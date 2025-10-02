pipeline {
    agent any

    environment {
        GCP_VM_USER   = 'shriram'
        GCP_VM_IP     = '34.127.22.0'
        TERRAFORM_DIR = '~/terraform-gcp-vm'
        SSH_KEY_PATH  = '/home/shriram/.ssh/jenkins_id_rsa'  // Path to your private key
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
                sh """
                    ssh -i ${SSH_KEY_PATH} -o StrictHostKeyChecking=no ${GCP_VM_USER}@${GCP_VM_IP} \\
                    "cd ${TERRAFORM_DIR} && terraform init && terraform plan"
                """
            }
        }

        stage('Terraform Apply') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                sh """
                    ssh -i ${SSH_KEY_PATH} -o StrictHostKeyChecking=no ${GCP_VM_USER}@${GCP_VM_IP} \\
                    "cd ${TERRAFORM_DIR} && terraform apply -auto-approve"
                """
            }
        }

        stage('Ansible Deploy') {
            steps {
                sh """
                    ssh -i ${SSH_KEY_PATH} -o StrictHostKeyChecking=no ${GCP_VM_USER}@${GCP_VM_IP} \\
                    "cd ~/ansible && ansible-playbook deploy.yml -i inv

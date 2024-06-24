pipeline {
    agent any
    
    environment {
        PACKER_BINARY = "/usr/bin/packer" // Path to the packer location
    }

    stages {
        stage('Git Checkout') {
            steps {
                // Checkout your source code repository
                git credentialsId: '4ac937d1-5c44-436f-a6a1-fc4b40246718', url: 'https://git-codecommit.eu-west-2.amazonaws.com/v1/repos/Packer-AWS-Ubuntu-AMI'

            }
        }        
              
        stage('Packer Init') {
            steps {
                // Packer Init plugin
                dir('/var/lib/jenkins/workspace/Packer-AWS-Ubuntu-AMI') {
                    sh "${env.PACKER_BINARY} init ."
                }
            }
        }   
        
        stage('Packer Format') {
            steps {
                // Packer Run Format in the project directory
                dir('/var/lib/jenkins/workspace/Packer-AWS-Ubuntu-AMI') {
                    sh "${env.PACKER_BINARY} fmt ."
                }
            }
        }
        
        stage('Packer Validate') {
            steps {
                // Packer Run validate in the project directory
                dir('/var/lib/jenkins/workspace/Packer-AWS-Ubuntu-AMI') {
                    sh "${env.PACKER_BINARY} validate ."
                }
            }
        }
              
        stage('Packer Build') {
            steps {
                // Apply the build using Packer
                dir('/var/lib/jenkins/workspace/Packer-AWS-Ubuntu-AMI') {
                    // input message: 'Do you want to proceed with the deployment?', ok: 'Deploy'
                    sh "${env.PACKER_BINARY} build ."
                        
                }
            }
        }
    }

post {
    always {
        emailext subject: 'AWS Packer AMI Jenkins Results', body: 'results attached.', to: 'joey.allen@gmx.co.uk', attachLog: true        
                                
        }
    }
}  
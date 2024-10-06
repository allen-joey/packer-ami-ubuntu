/* groovylint-disable-next-line CompileStatic */
pipeline {
    agent any

    environment {
        // Set AWS credentials as environment variables (or use AWS credentials plugin for Jenkins)
        // AWS_REGION = 'eu-west-2'         // Replace with your preferred AWS region
        // AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        // AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        PACKER_VERSION = '1.11.2'          // Replace with your preferred Packer version
    }

    stages {
        stage('Install Packer') {
            steps {
                script {
                    // Installing Packer (or verify it's installed)
                    sh """
                    if ! command -v packer &> /dev/null
                    then
                        echo "Packer not found, installing..."
                        /* groovylint-disable-next-line LineLength */
                        wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
                        unzip packer_${PACKER_VERSION}_linux_amd64.zip
                        sudo mv packer /usr/local/bin/
                    else
                        echo "Packer is already installed"
                    fi
                    """
                }
            }
        }

        stage('Validate Packer Template') {
            steps {
                script {
                    // Validate your Packer template
                    sh 'packer validate .'
                }
            }
        }

        stage('Build AMI with Packer') {
            steps {
                script {
                    // Execute the Packer build command
                    sh 'packer build .'
                }
            }
        }

        stage('Post-Build Steps') {
            steps {
                script {
                    // Optionally add any post-build steps like AMI tagging, or logging
                    echo 'AMI build completed.'
                }
            }
        }
    }

    post {
        always {
            // Cleanup step, if needed
            echo 'Pipeline finished.'
        }
        success {
            echo 'AMI built successfully!'
        }
        failure {
            echo 'AMI build failed.'
        }
    }
}

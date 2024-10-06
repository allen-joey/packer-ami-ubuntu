/* groovylint-disable-next-line CompileStatic */
pipeline {
    agent any

    environment {
        // Set AWS credentials as environment variables (or use AWS credentials plugin for Jenkins)
        // AWS_REGION = 'eu-west-2'         // Replace with your preferred AWS region
        // AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        // AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')        
    }

    stages {      
        stage('Validate Packer Template') {
            steps {
                script {
                    // Validate your Packer template
                    sh '/usr/bin/packer validate packer-build-ub22-ami.pkr.hcl'
                }
            }
        }

        stage('Build AMI with Packer') {
            steps {
                script {
                    // Execute the Packer build command
                    sh '/usr/bin/packer packer build packer-build-ub22-ami.pkr.hcl'
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

/* groovylint-disable-next-line CompileStatic */
pipeline {
    agent any

    stages {      
        stage('Validate Packer Template') {
            steps {
                script {
                    // Validate your Packer template
                    dir("/var/lib/jenkins/workspace/packer-ami-ubuntu")
                    sh 'packer validate packer-build-ub22-ami.pkr.hcl'
                }
            }
        }

        stage('Build AMI with Packer') {
            steps {
                script {
                    // Execute the Packer build command
                    dir("/var/lib/jenkins/workspace/packer-ami-ubuntu")
                    sh 'packer build packer-build-ub22-ami.pkr.hcl'
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

// This Jenkinsfile defines a declarative pipeline
/* groovylint-disable-next-line CompileStatic */
pipeline {
    // Specifies that this pipeline can run on any available agent
    agent any

    // Defines the sequence of stages that will be executed
    stages {
        // This stage checks out the source code from the SCM (Source Code Management) system
        stage('Checkout') {
            steps {
                // This command checks out the source code from the SCM into the Jenkins workspace
                checkout scm
            }
        }

        // This stage validates the Packer template
        stage('Validate Packer Template') {
            steps {
                script {
                    /* groovylint-disable-next-line LineLength */
                    // This command validates the Packer HCL (HashiCorp Configuration Language) template using the provided variable files.
                    sh 'packer validate packer-build-ub22-ami.pkr.hcl'
                }
            }
        }

        // This stage builds a image using Packer
        stage('Build Image') {
            when {
                /* groovylint-disable-next-line LineLength */
                // This condition ensures that this stage will only run if the previous 'Validate Packer Template' stage succeeded
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                script {
                    // This command builds image using Packer with the provided variable files
                    // It will forcefully build the image even if it exists and will prompt for action on any errors
                    // Ensure these file names are correct for your setup
                    sh 'packer build packer-build-ub22-ami.pkr.hcl'
                }
            }
        }
    }
}

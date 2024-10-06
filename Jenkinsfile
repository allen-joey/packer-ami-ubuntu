pipeline {
  agent any

  stages {
    stage('Packer - Build Ubuntu Image on vSphere') {
      steps {
        sh """
        #!/bin/bash
        cd /var/lib/jenkins/workspace/packer-ami-ubuntu
        packer validate packer-build-ub22-ami.pkr.hcl
        packer build packer-build-ub22-ami.pkr.hcl
        """
      }
    }
  }
}
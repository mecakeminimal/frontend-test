

import groovy.json.JsonSlurperClassic

  pipeline {
  agent {
    kubernetes {
      yamlFile 'KubernetesPod.yaml'
    }
  }

  stages {
      stage('Clone repositorดy') {
          steps {
              checkout scm
          }
      }
      stage('Build') {
          steps {
          container('maven') {
              echo 'Building...'
            }
          }
      }
      stage('Test') {
          steps {
              echo 'Testing...'
          }
      }
      stage('Deploy') {
          steps {
              echo 'Deploying...'
          }
      }
  }
post {
    always {
        echo 'Cleanup actions'
    }
}
}

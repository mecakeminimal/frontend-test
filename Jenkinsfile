

import groovy.json.JsonSlurperClassic


def commitSha1() {
  sh 'git rev-parse HEAD > commitSha1'
  def commit = readFile('commitSha1').trim()
  sh 'rm commitSha1'
  commit.substring(0, 11)
}

def projectName = "frontend"
def dockerRegistry = "registry.gitlab.com"
def repo = "${dockerRegistry}/dev/${projectName}"
def imageName = "${repo}"
def commitSha = commitSha1()
def tagPrefix = env.BRANCH_NAME
def imageTag = "${tagPrefix}-${commitSha}"

  pipeline {
  agent {
    kubernetes {
      yamlFile 'KubernetesPod.yaml'
    }
  }

  stages {
      stage('Clone repository') {
          steps {
              checkout scm
          }
      }
      stage('Build') {
          steps {
          container('docker') {
              docker.build("${imageName}:${imageTag}", ".")
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

pipeline {
  agent {
    label 'jenkins-master01'
  }

  environment {
    http_proxy   = 'http://webproxy.emarsys.at:3128'
    https_proxy  = 'http://webproxy.emarsys.at:3128'
    nexus_creds  = credentials('nexus-security-upload-user')
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '50'))
    disableConcurrentBuilds()
    timestamps()
    authorizationMatrix([
      'hudson.model.Item.Build:G_OIT_Operations',
      'hudson.model.Item.Cancel:G_OIT_Operations',
      'hudson.model.Item.Read:G_OIT_Operations'
    ])
  }

  triggers {
    gitlab(triggerOnPush: true, branchFilterType: 'NameBasedFilter', includeBranchesSpec: 'master', excludeBranchesSpec: '', secretToken: env.gitlab_token)
  }

  stages {
    stage('Build test environment') {
      steps {
        sh 'BUILD=1 make build'
      }
    }
    stage('Deploy RPM package') {
      steps {
        sh 'BUILD=1 make staging-deploy'
      }
    }
  }

  post {
    success {
      build(job: 'Security/OpenVPN scripts', propagate: false, wait: false, parameters: [[$class: 'BooleanParameterValue', name: 'FORCE_REBUILD', value: true]])
    }
    fixed {
      slackSend(tokenCredentialId: 'slack-team-security-ops', color: 'good', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Back to normal after ${currentBuild.durationString} (<${env.BUILD_URL}|Open>)")
    }
    failure {
      slackSend(tokenCredentialId: 'slack-team-security-ops', color: 'danger', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Failure after ${currentBuild.durationString} (<${env.BUILD_URL}|Open>)")
    }
  }
}

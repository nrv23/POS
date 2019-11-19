pipeline {
    // Syntax: https://jenkins.io/doc/book/pipeline/syntax/
    // Steps: https://jenkins.io/doc/pipeline/steps/
    
    agent any
    
    // Plugins
    // https://jenkins.io/doc/pipeline/steps/nodejs/
    // https://jenkins.io/doc/pipeline/steps/pipeline-npm/
    // 

    stages {
        stage('Validate') {
            steps {
                echo "Reading Variables..."
                echo "BRANCH_NAME: ${env.BRANCH_NAME}"
                echo "CHANGE_AUTHOR: ${env.CHANGE_AUTHOR}"
                echo "CHANGE_AUTHOR_DISPLAY_NAME: ${env.CHANGE_AUTHOR_DISPLAY_NAME}"
                echo "CHANGE_AUTHOR_EMAIL: ${env.CHANGE_AUTHOR_EMAIL}"
                echo "CHANGE_TARGET: ${env.CHANGE_TARGET}"
                echo "JOB_NAME: ${env.JOB_NAME}"
                echo "JOB_BASE_NAME: ${env.JOB_BASE_NAME}"
                echo "WORKSPACE: ${env.WORKSPACE}"
                echo "CHANGE_TARGET: ${env.CHANGE_TARGET}"
                echo "JENKINS_HOME: ${env.JENKINS_HOME}"
                echo "JENKINS_URL: ${env.JENKINS_URL}"
                echo "BUILD_URL: ${env.BUILD_URL}"
                echo "JOB_URL: ${env.JOB_URL}"

                echo "${HOME}"
                echo "${USER}"

                sh '''
                gradle --version
                '''
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh './gradlew ci'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
    post {
        always { //Send an email to the person that broke the build
            // guide: https://gist.github.com/aerobless/37561bb0fb45b7e8732beaafad1cba26
            step([$class                  : 'Mailer',
                  notifyEveryUnstableBuild: true,
                  recipients              : [emailextrecipients([[$class: 'CulpritsRecipientProvider'], [$class: 'RequesterRecipientProvider']])].join(' ')])
        }
    }
}

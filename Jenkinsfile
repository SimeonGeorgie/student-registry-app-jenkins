pipeline {
    agent any

    environment {
        NODEJS_VERSION = '14.0.0' // Specify the Node.js version you want to use
    }

    stages {
        stage('Setup Node.js') {
            steps {
                script {
                    // Install Node.js
                    sh '''
                    # Install Node.js
                    curl -sL https://deb.nodesource.com/setup_$NODEJS_VERSION | sudo -E bash -
                    sudo apt-get install -y nodejs
                    '''
                }
            }
        }
    
        stage('Checkout code') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'test-pipeline', url: 'https://github.com/SimeonGeorgie/student-registry-app-jenkins'
        }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    // Install project dependencies
                    sh 'npm install'
                }
            }
        }

        stage('Start Application') {
            steps {
                script {
                    // Start the application in the background
                    sh 'nohup npm start &'
                }
            }
        }

        stage('Test application') {
            steps {
                script {
                    // Run the tests
                    sh 'npm test'
                }
            }
        }

    }

    post {
        always {
            // Cleanup actions, if necessary
            script {
                // Stop the application if it was started
                sh 'pkill -f "node" || true'
            }
        }

        success {
            echo 'Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}
}
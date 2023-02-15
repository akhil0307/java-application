pipeline{
    agent any
    environment {
        PATH = "/opt/apache/bin:$PATH"
    }
    stages{
        stage("cloneing"){
            steps{
            git branch: 'main', credentialsId: 'akhil0307', url: 'https://github.com/akhil0307/java-application'
            }
        }
        stage("build"){
            steps{
                echo "building with maven starts"
                sh 'mvn clean install  -Dmaven.test.skip=false'
                echo "maven build completed"
            }
        }
         stage ("Sonar Analysis") {
            environment {
               scannerHome = tool 'sonar-cloud'
            }
            steps {
                echo '<--------------- Sonar Analysis started  --------------->'
                withSonarQubeEnv('sonar-cloud') {    
                    sh "${scannerHome}/bin/sonar-scanner"
                echo '<--------------- Sonar Analysis stopped  --------------->'
                }    
               
            }   
        }
    }
}

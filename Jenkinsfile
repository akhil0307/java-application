pipeline{
     agent {
        node {
            label "slave1"
        }
    }
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
               scannerHome = tool 'sonarcloud'
            }
            steps {
                echo '<--------------- Sonar Analysis started  --------------->'
                withSonarQubeEnv('sonarcloud') {    
                    sh "${scannerHome}/bin/sonar-scanner"
                echo '<--------------- Sonar Analysis stopped  --------------->'
                }    
               
            }   
        }
        stage("Quality Gate") {
            steps {
                script {
                  echo '<--------------- Sonar Gate Analysis Started --------------->'
                    timeout(time: 5, unit: 'MINTUES'){
                       def qg = waitForQualityGate()
                        if(qg.status !='OK') {
                            error "Pipeline failed due to quality gate failures: ${qg.status}"
                        }
                    }  
                  echo '<--------------- Sonar Gate Analysis Ends  --------------->'
                }
            }
        }
    }
}

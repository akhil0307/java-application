pipeline{
    agent{
        label "slave1"
    }
    environment {
        PATH = "/opt/apache/bin:$PATH"
    }
    stages{
        stage("build"){
            steps{
                echo "building with maven starts"
                sh 'mvn clean install  -Dmaven.test.skip=false'
                echo "maven build completed"
            }
        }
    }
}

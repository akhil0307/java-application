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
                sh 'mvn clean deploy -Dmaven.test.skip=false'
                echo "maven build completed"
            }
        }
    }
}

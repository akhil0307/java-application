def registry = 'https://ntrcreations.jfrog.io'
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
//         stage("Quality Gate") {
//             steps {
//                 script {
//                   echo '<--------------- Sonar Gate Analysis Started --------------->'
//                     timeout(time: 15, unit: 'MINUTES'){
//                        def qg = waitForQualityGate()
//                         if(qg.status !='OK') {
//                             error "Pipeline failed due to quality gate failures: ${qg.status}"
//                         }
//                     }  
//                   echo '<--------------- Sonar Gate Analysis Ends  --------------->'
//                 }
//             }
//         }
        stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrog-01"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "ntr-creations-libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
                    
            }   
        }
    }
}
}

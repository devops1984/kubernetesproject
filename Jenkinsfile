pipeline {
    agent any
	tools {
	    maven 'maven'
	}
	stages {
	    stage('Build'){
		    steps{
			     sh script: 'mvn clean package'
			     
			}
		}
		
		stage('Upload War to Nexus'){
		    steps{
			     nexusArtifactUploader artifacts: [
				     [
					     artifactId: 'webapp', 
					     classifier: '', 
					     file: 'webapp/target/webapp.war', 
					     type: 'war'
				     ]
			     ], 
				     credentialsId: 'NEXUS3', 
				     groupId: 'com.example.maven-project', 
				     nexusUrl: '51.124.248.36:8081', 
				     nexusVersion: 'nexus3', 
				     protocol: 'http', 
				     repository: 'demo-app', 
				     version: '1.0.0'
			}
		}
		stage('Docker Build and Tag') {
                    steps {
			    sshPublisher(publishers: [sshPublisherDesc(configName: 'dockerhost', 
				  transfers: [sshTransfer(cleanRemote: false, excludes: '', 
				  execCommand: '''docker build -t demoapp:latest .
                                  docker tag demoapp k2r2t2/demoapp:latest''', 
                                  execTimeout: 120000, 
				  flatten: false, 
                                  makeEmptyDirs: false, 
				  noDefaultExcludes: false, 
				  patternSeparator: '[, ]+', 
	                          remoteDirectory: '.', 
				  remoteDirectorySDF: false, 
				  removePrefix: 'webapp/target', 
				  sourceFiles: 'webapp/target/*.war')], 
			          usePromotionTimestamp: false, 
			          useWorkspaceInPromotion: false, 
				  verbose: false)])
                       }
                }
		/*stage('Publish Docker Image to DockerHub') {
                    steps {
			    withDockerRegistry([credentialsID: "dockerHub" , url: ""])	{	    
			     sh 'docker push k2r2t2/demoapp:latest'
			    }
                       }
                }*/
		stage('RUN docker container on remote host') {
                    steps {
			     sh 'docker -H ssh://dockeradmin@20.14.98.51 run -d -p 8003:8080 k2r2t2/demoapp'
                       }
                }
	}
}   

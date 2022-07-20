pipeline {
    agent any
	tools {
	    maven 'Maven3'
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
		stage('copy build artifact') {
                    steps {
         		withCredentials([string(credentialsId: 'copyuser', variable: 'pocuser')]) {
				sh 'su --login pocuser -p ${copyuser}' 
			    sh 'cp /var/lib/jenkins/workspace/Demo-app/webapp/target/webapp.war /opt/tomcat/webapps'
                          }
                     }
	       }
		/* stage('Docker Build and Tag') {
                    steps {
			     sh 'docker build -t demoapp:latest .'
			     sh 'docker tag demoapp k2r2t2/demoapp:latest'
                       }
                }
		stage('Publish Docker Image to DockerHub') {
                    steps {
			    withDockerRegistry([credentialsID: "dockerHub" , url: "https://hub.docker.com"])	{	    
			     sh 'docker push k2r2t2/demoapp:latest'
			    }
                       }
                }
		stage('RUN docker container on remote host') {
                    steps {
			     sh 'docker -H ssh://azureuser@51.124.248.36 run -d -p 8003:8080 k2r2t2/demoapp'
                       }
                }*/
	}
}   

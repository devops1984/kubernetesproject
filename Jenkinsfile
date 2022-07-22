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
			    sh 'sudo scp ./*.war ssh://ubuntu@3.101.138.75 /home/ubuntu'
			    sh 'sudo scp ./Dockerfile ssh://ubuntu@3.101.138.75 /home/ubuntu'
			    sh "ssh://ubuntu@3.101.138.75 'su dockeradmin','docker build -t demoapp:latest .'"
			    sh 'ssh://ubuntu@3.101.138.75 "su dockeradmin", "docker tag demoapp k2r2t2/demoapp:latest"' 
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
			     sh "ssh://ubuntu@3.101.138.75 'su dockeradmin', 'docker run -d -p 8003:8080 k2r2t2/demoapp'"
                       }
                }
	}
}   

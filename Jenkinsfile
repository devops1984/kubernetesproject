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
		stage('Docker Build and Tag') {
                    steps {
			     sh 'docker build -t demoapp:latest .'
			     sh 'docker tag demoapp k2r2t2/demoapp:$BUILD_NUMBER'
                       }
                }
		stage('Publish image to nexus') {
                    steps {
			     sh 'docker build -t demoapp:latest .'
			     sh 'docker tag demoapp k2r2t2/demoapp:$BUILD_NUMBER'
                       }
                }
	}
}   

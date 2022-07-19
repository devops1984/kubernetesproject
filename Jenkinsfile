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
			     sh script: 'mvn clean package'
			}
		}
	}
}   

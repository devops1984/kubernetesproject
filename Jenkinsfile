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
		stage('Docker Build and Deploy') {
                    steps {
			    sshPublisher(publishers: [sshPublisherDesc(configName: 'dockerhost', transfers: [sshTransfer(cleanRemote: false, excludes: '', 
			execCommand: 'sh **/*/deploy.sh', 
	              execTimeout: 120000, 
		      flatten: false, makeEmptyDirs: false, 
		      noDefaultExcludes: false, 
		      patternSeparator: '[, ]+', 
		      remoteDirectory: '/home/ubuntu', 
		     remoteDirectorySDF: false, removePrefix: '', 
		     sourceFiles: '**/**')], 
		    usePromotionTimestamp: false, 
		    useWorkspaceInPromotion: false, verbose: true)])
                       }
                }
		/*stage('Publish Docker Image to DockerHub') {
                    steps {
			    withDockerRegistry([credentialsID: "dockerHub" , url: ""])	{	    
			     sh 'docker push k2r2t2/demoapp:latest'
			    }
                       }
                }*/
		
	}
}   

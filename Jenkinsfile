pipeline {
    agent any
	environment {
	    PATH = "$PATH:/usr/share/maven/bin"
	}
	 stages {
                stage('Build'){
		    steps{
			     sh " mvn clean package"
			     
			}
		}
               stage('Sonar Analysis') {
                     steps {
                      withSonarQubeEnv('Sonarqube') {
                             sh " mvn sonar:sonar \
			          -Dsonar.host.url=http://54.183.145.72:9000 \
			          -Dsonar.login=squ_14e51b0606b52da0636a45d47d5c65953ecdc330"
                             }
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
		stage('Transfer files to DockerHost') {
                    steps {
			    sshPublisher(publishers: [sshPublisherDesc(configName: 'dockerhost', transfers: [sshTransfer(cleanRemote: false, excludes: '', 
	              execCommand: '',
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
		stage ('Create Docker Image') {
                     steps{
                        sshagent(credentials : ['dockerhost']) {
				 sh 'whoami'
				 sh 'pwd'
				 sh 'ls -lrt'
				 sh '''
                [ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
                ssh-keyscan -t rsa,dsa 3.101.133.109 >> ~/.ssh/known_hosts
                ssh jenkins@3.101.133.109 
		sudo docker build -t k2r2t2/demoapp .'''
                                           }
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

pipeline {
    agent any
	environment {
	    PATH = "$PATH:/usr/share/maven/bin"
	}
	 stages {
                stage('Maven Build'){
		    steps{
			     sh " mvn clean package"   
			}
		}
		 stage('Sonar Analysis') {
                     steps {
                      withSonarQubeEnv('Sonarqube') {
                             sh " mvn sonar:sonar \
			          -Dsonar.host.url=http://54.183.145.72:9000 \
			          -Dsonar.login=sqa_6abde3937772d88f85a81d5569453c7ab5c5b5a8"
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
		stage('Transfer artifact to Ansible') {
                    steps {
			    sshPublisher(publishers: 
			      [sshPublisherDesc(configName: 'jenkins', 
				  transfers: [sshTransfer(cleanRemote: false, 
				  excludes: '', 
				  execCommand: 'rsync -avh  /var/lib/jenkins/workspace/kubernetesproject/* root@172.31.43.126:/opt', 
				  execTimeout: 120000, flatten: false, 
				  makeEmptyDirs: false, noDefaultExcludes: false, 
				  patternSeparator: '[, ]+', 
				  remoteDirectory: '', remoteDirectorySDF: false, 
				  removePrefix: '', sourceFiles: '')], 
				  usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true)])
                       }
                }
		stage ('Docker Image Creation') {
			steps{
			      sshPublisher(publishers: 
		              [sshPublisherDesc(configName: 'ansible', 
			      transfers: [sshTransfer(cleanRemote: false, 
			      excludes: '', execCommand: '''cd /opt
                                                            docker image build -t $JOB_NAME:v1.$BUILD_ID .
                                                            docker image tag $JOB_NAME:v1.$BUILD_ID k2r2t2/$JOB_NAME:v1.$BUILD_ID
                                                            docker image tag $JOB_NAME:v1.$BUILD_ID k2r2t2/$JOB_NAME:latest
                                                            docker image push k2r2t2/$JOB_NAME:v1.$BUILD_ID
                                                            docker image push k2r2t2/$JOB_NAME:latest
                                                            docker image rmi $JOB_NAME:v1.$BUILD_ID k2r2t2/$JOB_NAME:v1.$BUILD_ID k2r2t2/$JOB_NAME:latest''', 
			      execTimeout: 120000, flatten: false, makeEmptyDirs: false, 
			      noDefaultExcludes: false, patternSeparator: '[, ]+', 
			      remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], 
			      usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true)])
                          }
		}
		stage ('Deploy on k8s Cluster') {
			steps{
			      sshPublisher(publishers: 
				 [sshPublisherDesc(configName: 'ansible', 
				     transfers: [sshTransfer(cleanRemote: false, 
					  excludes: '', execCommand: 'ansible-playbook /opt/ansible.yml', 
					  execTimeout: 120000, flatten: false, 
					  makeEmptyDirs: false, noDefaultExcludes: false, 
					  patternSeparator: '[, ]+', remoteDirectory: '', 
					  remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], 
					  usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true)])
                          }
		}
	}
}   

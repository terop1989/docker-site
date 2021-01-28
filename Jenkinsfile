#!groovy
// Check ub1 properties
properties([disableConcurrentBuilds()])

pipeline {
	agent none

	triggers{pollSCM('*/5 * * * *')}
	
	options {
		buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
		}
	
	environment
		{
		DockerImageName='my_docker_pipe_image'	
		DockerImageTag='latest'
		
		DockerRepositoryAddress='docker.io'
				
                K8s_Namespace='test'
                Manifest_file='deployment.yml'
		}
	
	stages {
					
		stage("Build Image")
			{
                        agent {label 'docker'}
			steps	{
				
				
					withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')])
					{
						sh 'docker build . -t $DOCKER_USER/${DockerImageName}:${DockerImageTag}'
						sh 'docker login ${DockerRepositoryAddress} -u $DOCKER_USER -p $DOCKER_PASSWORD'
						sh 'docker push ${DockerRepositoryAddress}/$DOCKER_USER/${DockerImageName}:${DockerImageTag}'
					}				
					

				}
			  
			}
	
		stage("Deploy on K8s")
			{
			agent {label 'kubectl'}
			steps { 
				sh 'kubectl apply -n ${K8s_Namespace} -f ${Manifest_file}' 

				}
			}

		}
	}


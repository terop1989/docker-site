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
		DockerImageFolder='image'
		DockerImageName='my_docker_pipe_image'	
		DockerImageTag='latest'
		
		DockerRepositoryAddress='docker.io'
		DockerRepositoryAccount='terop1989'
		
				
                K8s_Namespace='test'
                Manifest_file='deployment.yml'
		}
	
	stages {
					
		stage("Build Image")
			{
                        agent {label 'docker'}
			steps	{
				
				script
					{
						
					def dockerImage = docker.build("${DockerRepositoryAccount}/${env.DockerImageName}:${env.DockerImageTag}", " ./${env.DockerImageFolder}")
					docker.withRegistry('', 'dockerhub') 
						{
						dockerImage.push('${DockerImageTag}')
						}	
										
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


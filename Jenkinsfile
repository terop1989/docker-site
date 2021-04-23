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
		DockerRegistryAccount='terop1989'
		}
	
	stages {
					
		stage("Build Image")
			{
                        agent {label 'docker'}
			steps	{
				script  {
						
					docker.withRegistry('', 'dockerhub') 
						{
						def dockerImage = docker.build( "$DockerRegistryAccount/${DockerImageName}:${DockerImageTag}" , "  ./image/" )
						dockerImage.push()
						}	
					}
				}
			}
	
		stage("Deploy on K8s")
			{
			agent {label 'kubectl'}
			steps { 

				script {
					kubernetesDeploy(configs: "./k8s/namespace.yml" , kubeconfigId: "kub01-secret")
					kubernetesDeploy(configs: "./k8s/pvc.yml" , kubeconfigId: "kub01-secret")
					kubernetesDeploy(configs: "./k8s/configmap.yml", kubeconfigId: "kub01-secret")
					kubernetesDeploy(configs: "./k8s/deployment.yml", kubeconfigId: "kub01-secret")
					kubernetesDeploy(configs: "./k8s/service.yml", kubeconfigId: "kub01-secret")
					kubernetesDeploy(configs: "./k8s/ingress.yml", kubeconfigId: "kub01-secret")
					}
				}
			}
		}
	}


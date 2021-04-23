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
		
				
                Namespace_file='k8s/namespace.yml'
                Deployment_file='k8s/deployment.yml'
                Service_file='k8s/service.yml'
                Ingress_file='k8s/ingress.yml'
                ConfigMap_file='k8s/configmap.yml'
		PVC_file='k8s/pvc.yml'
		
		}
	
	stages {
					
		stage("Build Image")
			{
                        agent {label 'docker'}
			steps	{
				script  {
						
					docker.withRegistry('', 'dockerhub') 
						{
						def customImage = docker.build("${DockerImageName}:${DockerImageTag}")
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
					kubernetesDeploy(configs: "./${Namespace_file}" , kubeconfigId: "kub01-secret")
					kubernetesDeploy(configs: "./${PVC_file}" , kubeconfigId: "kub01-secret")
					kubernetesDeploy(configs: "./${ConfigMap_file}", kubeconfigId: "kub01-secret")
					kubernetesDeploy(configs: "./${Deployment_file}", kubeconfigId: "kub01-secret")
					kubernetesDeploy(configs: "./${Service_file}", kubeconfigId: "kub01-secret")
					kubernetesDeploy(configs: "./${Ingress_file}", kubeconfigId: "kub01-secret")
					}
				}
			}
		}
	}


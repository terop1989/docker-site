#!groovy
// Check ub1 properties
properties([disableConcurrentBuilds()])

pipeline {
	agent {
		label 'master'
	      }

	options {
		buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
		}

	stages {
	
		stage("Preparations") 
			{
			steps 
				{
				sh 'ssh docker@10.0.2.7 \'whoami\''
				}
			}		
		
		stage("Docker build")
			{

			steps 
								
				{
				sh 'ssh docker@10.0.2.7 \'docker build -t my_docker_pipe_image github.com/terop1989/docker-site/Dockerfile.in\''
				}
			      
			}
		}
	}



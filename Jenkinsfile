#!groovy
// Check ub1 properties
properties([disableConcurrentBuilds()])

pipeline {
	agent {
		label 'master'
	      }

	triggers{pollSCM('*/10 * * * *')}
	
	options {
		buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
		}
	
	environment
		{
		DockerImageName='my_docker_pipe_image'	
	
		}
	
	stages {
					
		stage("Build Image")
			{

			steps 
								
				{
				sh 'ssh docker@10.0.2.7 \'docker build -t {DockerImageName} github.com/terop1989/docker-site\''
				}
     
			}
	
		stage("Run Container")
			{
			steps	
				{
				sh 'ssh docker@10.0.2.7 \'docker run --name web01 -d -p 1211:80 my_docker_pipe_image\''
				}
			}

		stage("Delete Container")
			{
			steps
				{
				sh 'ssh docker@10.0.2.7 \'docker rm -f web01\''
				}
		
			}


		}
	}



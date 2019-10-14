#!groovy
// Check ub1 properties
properties([disableConcurrentBuilds()])

pipeline {
	agent {
		label 'master'
	      }

	triggers{pollSCM('*/5 * * * *')}
	
	options {
		buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
		}
	
	environment
		{
		DockerImageName='my_docker_pipe_image'	
		ContainerName='web01'
		DockerAddress='10.0.2.7'
		DockerUserName='docker'
		RepositoryServer='github.com'
		RepositoryAccount='terop1989'
		RepositoryProject='docker-site'
		}
	
	stages {
					
		stage("Build Image")
			{

			steps 
								
				{
				sh 'ssh ${DockerUserName}@${DockerAddress} \'docker build -t \' ${DockerImageName} ${RepositoryServer}/${RepositoryAccount}/${RepositoryProject}\'
				}
     
			}
	
		stage("Run Container")
			{
			steps	
				{
				sh 'ssh ${DockerUserName}@${DockerAddress} \'docker run --name \' ${ContainerName} \' -d -p 1211:80 \' ${DockerImageName}'
				}
			}

		stage("Delete Container")
			{
			steps
				{
				sh 'ssh ${DockerUserName}@${DockerAddress} \'docker rm -f \' ${ContainerName}'
				}
		
			}


		}
	}



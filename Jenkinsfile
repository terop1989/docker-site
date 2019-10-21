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
		DockerImageTag='latest'
		ContainerName='web01'
		DockerAddress='10.0.2.7'
		DockerUserName='docker'
		DockerSwarmMasterNodeAddress='10.0.2.7'
		RepositoryServer='github.com'
		RepositoryAccount='terop1989'
		RepositoryProject='docker-site'
		DockerHubAccount='terop1989'
		}
	
	stages {
					
		stage("Build Image")
			{

			steps 
								
				{
				sh 'ssh ${DockerUserName}@${DockerAddress} \'docker build -t \' ${DockerHubAccount}/${DockerImageName}:${DockerImageTag} ${RepositoryServer}/${RepositoryAccount}/${RepositoryProject}'
				}
     
			}
	
		stage("Docker Push")
			{
			steps
				{
				withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')])
					{
						
						sh 'ssh ${DockerUserName}@${DockerAddress} \'docker login docker.io -u \' $DOCKER_USER \' -p  \' $DOCKER_PASSWORD '
						
					
						
						sh 'ssh ${DockerUserName}@${DockerAddress} \'docker push docker.io/\'${DockerHubAccount}/${DockerImageName}:${DockerImageTag}'
					
						
					}
				}
			}
		

			
		stage("DockerSwarm Service deploy")
			{
			steps
				{
				sh 'ssh ${DockerUserName}@${DockerSwarmMasterNodeAddress} \'docker service create --replicas 1 --name \' ${ContainerName} ${DockerHubAccount}/${DockerImageName}:${DockerImageTag}' 
				}
			}
		
		stage("DockerSwarm Service remove")
			{
			steps
				{
				sh 'ssh ${DockerUserName}@${DockerSwarmMasterNodeAddress} \'docker service rm \' ${ContainerName}   '
				}
			}


		}
	}



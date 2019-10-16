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
				sh 'ssh ${DockerUserName}@${DockerAddress} \'docker build -t \' ${DockerHubAccount}/${DockerImageName} ${RepositoryServer}/${RepositoryAccount}/${RepositoryProject}'
				}
     
			}
	
		stage("Docker Push")
			{
			steps
				{
				sh 'ssh ${DockerUserName}@{DockerAddress} \'docker push \''
				
				}
			}
	
		

			
		stage("DockerSwarm Service deploy")
			{
			steps
				{
				sh 'ssh ${DockerUserName}@${DockerSwarmMasterNodeAddress} \'docker service create --replicas 1 --name \' ${ContainerName} ${DockerImageName}' 
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



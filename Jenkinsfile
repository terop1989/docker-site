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
		DockerBuilderAddress='10.0.2.7'
		DockerBuilderUserName='docker'
		DockerSwarmUserName='docker'
		DockerSwarmMasterNodeAddress='10.0.2.7'
		GitRepositoryServer='github.com'
		GitRepositoryAccount='terop1989'
		GitRepositoryProject='docker-site'
		BranchName='master'
		Par='blob'
		DockerRepositoryAddress='docker.io'
		DockerRepositoryAccount='terop1989'
		DockerServiceName='web222'
		DockerComposeFile='terop.yml'
		}
	
	stages {
					
		stage("Build Image")
			{

			steps 
								
				{
				sh 'ssh ${DockerBuilderUserName}@${DockerBuilderAddress} \'docker build -t \' ${DockerRepositoryAccount}/${DockerImageName}:${DockerImageTag} ${GitRepositoryServer}/${GitRepositoryAccount}/${GitRepositoryProject}'
				}
     
			}
	
		stage("Docker Push")
			{
			steps
				{
				withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')])
					{
						
						sh 'ssh ${DockerBuilderUserName}@${DockerBuilderAddress} \'docker login \' ${DockerRepositoryAddress} \'-u \' $DOCKER_USER \' -p \'  $DOCKER_PASSWORD '
						
					
						
						sh 'ssh ${DockerBuilderUserName}@${DockerBuilderAddress} \'docker push \' ${DockerRepositoryAddress}/${DockerRepositoryAccount}/${DockerImageName}:${DockerImageTag}'
					
						
					}
				}
			}
		

			
		stage("DockerSwarm Service deploy")
			{
			steps { script
				{
                                sh 'cat Jenkinsfile | ssh ${DockerSwarmUserName}@${DockerSwarmMasterNodeAddress} \'docker stack deploy -c \'  ${DockerServiceName} \' --with-registry-auth\'' 
				sh 'ssh ${DockerSwarmUserName}@${DockerSwarmMasterNodeAddress} \'docker service ps\' ${ContainerName}'
				sh 'ssh ${DockerSwarmUserName}@${DockerSwarmMasterNodeAddress} \'docker service rm \' ${ContainerName}   '
				}
			}}


		}
	}



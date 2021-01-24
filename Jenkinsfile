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
		
		DockerBuilderAddress='docker.local.com'
		DockerBuilderUserName='docker'
		
		GitRepositoryName='https://github.com/terop1989/docker-site.git'		
		BranchName="${env.BRANCH_NAME}"

		DockerRepositoryAddress='docker.io'
		DockerRepositoryAccount='terop1989'
		

                KubectlAddress='ubuntu04.local.com'
                KubectlUserName='user04'
                K8s_Namespace='test'
                Deployment_manifest='deployment.yml'
		}
	
	stages {
					
		stage("Build Image")
			{
                        agent {label 'docker'}
			steps 
							
				{
				sh 'docker build -t ${DockerRepositoryAccount}/${DockerImageName}:${DockerImageTag} ${GitRepositoryName}#${BranchName}'

				withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')])
                                        {
						sh 'docker login ${DockerRepositoryAddress} -u $DOCKER_USER -p $DOCKER_PASSWORD'
		                                sh 'docker push ${DockerRepositoryAddress}/${DockerRepositoryAccount}/${DockerImageName}:${DockerImageTag}'
							

                                        }				


				}
				
     
			}
	
		
			
		stage("Deploy on K8s")
			{
			steps { script
				{
				sh 'scp ${Deployment_manifest} ${KubectlUserName}@${KubectlAddress}:~'
                                sh 'ssh ${KubectlUserName}@${KubectlAddress} \'kubectl apply -n \' ${K8s_Namespace} \' -f  \'  ${Deployment_manifest}' 
				
				}
			}}


		}
	}



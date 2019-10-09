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
				sh 'whoami'
				}
			}		
		
		stage("Docker build")
			{

			steps 
				{
				'ssh docker@10.0.2.7'
				}
				
				{
				'docker build -t my_docker_pipe_image .'
				}
			      
			}
		}
	}



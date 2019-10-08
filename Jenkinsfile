#!groovy
// Check ub1 properties
properties([disableConcurrentBuilds])

pipeline {
	agent {
		label 'master'
		}
	options {
		buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
		
	}
	stages {
		stage("Preparations") {
			steps {
				sh 'whoami'
			}
		}
	}
}

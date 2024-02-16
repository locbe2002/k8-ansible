@Library('jenkins-integration-module@v1.0.1') _
//def artiMavenMap = [:] //Required for mavenArti* helpers
pipeline {

    agent { label 'etad_k8_master' }
/*
*/
    options {
        buildDiscarder(logRotator(numToKeepStr: '3')) //Number of run results to keep
        disableConcurrentBuilds() //Ensure only one
        timeout(time: 20, unit: 'MINUTES') //Timeout for the whole job
        retry(0) //Retry on failure
        timestamps() //Prepend all console output with timestamps
    }

    environment {
        KUBECTL_VERSION = "1.21.4"
    }

      parameters {

        string (name: "Master_Ip", defaultValue: "", description: "The K8 Master node ip address")
//        booleanParam(name: 'DEPLOY_Consul',            defaultValue: false, description: ' Deploy consul')
//        choice(name: 'Worker_Ips', choices: [ "Do_nothing", "Install", "Dry-Run", "Uninstall" ])
        text(name: 'Worker_Node_Ips', defaultValue: '0.0.0.0\n0.0.0.1\n0.0.0.2\n0.0.0.3\n0.0.0.4', description: 'k8 workers nodes')    
    }

    stages {
        stage('Init') {
            steps {
                script {
                    currentBuild.displayName = "${GIT_BRANCH}"
                    currentBuild.description = "VFIOT Deployment of ECS8.6 in SD K8s Cluster 12"
                }
            }
        }

        stage('Setup Env') {
            steps {
                sh '''
                    env
                    ## setup kubectl
                    rm -rf ${WORKSPACE}/bin && mkdir ${WORKSPACE}/bin
                    '''
            }
        }
        stage('running kubeadmin init') {
            steps {
                sh '''
                echo ${Worker_Node_Ips}
                '''
            }
        }
    }
}

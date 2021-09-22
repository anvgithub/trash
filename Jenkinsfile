pipeline {
    agent any

    stages {
    
        stage('Terraform Init'){
            
            steps {
             ansiColor('xterm') {
                  withCredentials([azureServicePrincipal(
                    credentialsId: 'jenkins',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID')]) {
                         sh """
                        echo " Terraform init"
                        terraform init 
                        """
                    }
                }
                    
            }
        }

        
       stage('Terraform Plan'){
            
            steps {
             ansiColor('xterm') {
                  withCredentials([azureServicePrincipal(
                    credentialsId: 'jenkins',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID')]) {
                         sh """
                        echo "Creating Terraform plan"
                        terraform plan
                        """
                    }
                }
                    
            }
        }

        stage('Waiting for Approval'){
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input (message: "Do you agree to create the infrastructure?")
                }
            }
        
        }

      stage('Terraform Apply'){
            
            steps {
             ansiColor('xterm') {
                  withCredentials([azureServicePrincipal(
                    credentialsId: 'jenkins',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID')]) {
                         sh """
                        echo "Terraform Apply "
                        terraform apply -auto-approve 
                        """
                       script {
                       env.TEST_VARIABLE = sh 'terraform output vm_ip'
                       }
                      
                       sh 'echo "I can access $TEST_VARIABLE in shell command as well."'
                    }
                }
                    
            }
        }
        stage('Waiting for Destroy'){
            steps {
                timeout(time: 12, unit: 'HOURS') {
                    input (message: "Are you sure destroying the infrastructure?")
                }
            }
        
        }

        stage('Terraform Destroy'){
            
            steps {
             ansiColor('xterm') {
                  withCredentials([azureServicePrincipal(
                    credentialsId: 'jenkins',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID')]) {
                         sh """
                        echo "Terraform Destroy "
                        terraform destroy -auto-approve 
                        """
                    }
                }
                    
            }
        }
    }
}

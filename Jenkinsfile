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
                        echo "Creating Terraform init"
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
                    input (message: "Deploy the infrastructure?")
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
                        echo "Apply "
                        terraform apply -auto-approve 
                        export vmss_ip=${terraform output vm_ip}
                        echo 'host1 ansible_ssh_port=50001 ansible_ssh_host=$vmss_ip' > /home/anv/inventory
                        echo 'host2 ansible_ssh_port=50002 ansible_ssh_host=$vmss_ip' >> home/anv/inventory

                        cat inventory
                        """
                    }
                }
                    
            }
        }
        stage('Waiting for Destroy'){
            steps {
                timeout(time: 12, unit: 'HOURS') {
                    input (message: "Destroy the infrastructure?")
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
                        echo "Apply "
                        terraform destroy -auto-approve 
                        """
                    }
                }
                    
            }
        }
    }
}

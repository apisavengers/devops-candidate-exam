pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
                echo "Executing Terraform Init"
                sh 'terraform init'
            }
        }
        stage("TF Validate"){
            steps{
                echo "Validating Terraform Code"
                sh 'terraform validate'
            }
        }
        stage("TF State List"){
            steps{
                echo "Executing Terraform Plan"
                sh 'terraform state list'
            }
        }
//        stage("TF Remove Resource"){
//            steps{
//                echo "Executing Terraform Plan"
//                sh 'terraform state rm ap_route_table'
//            }
//        }
//        stage("TF Plan"){
//            steps{
//                echo "Executing Terraform Plan"
//                sh 'terraform plan'
//            }
//        }
//        stage("TF Apply"){
//            steps{
//                echo "Executing Terraform Apply"
//                sh 'terraform apply -auto-approve'
//            }
//        }
//        stage("Invoke Lambda"){
//            steps{
//                echo "Invoking your AWS Lambda"
//                sh 'aws lambda invoke --function-name andyphamlambda --log-type Tail result.txt'
//            }
//        }
    }
}

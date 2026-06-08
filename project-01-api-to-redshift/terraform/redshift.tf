# resource "aws_redshiftserverless_namespace" "namespace" {
#
#   namespace_name = "api-etl-namespace"
#
#   admin_username = "adiuser"
#
#   admin_user_password = "Password@12345"
# }
#
#
# resource "aws_redshiftserverless_workgroup" "workgroup" {
#
#   workgroup_name = "api-etl-workgroup"
#
#   namespace_name = aws_redshiftserverless_namespace.namespace.namespace_name
#
#   base_capacity = 8
# }
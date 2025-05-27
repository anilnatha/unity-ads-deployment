# Register health check URL
resource "aws_ssm_parameter" "jupyter_health_url" {
  name = "/unity/${var.project}/${var.venue}/component/jupyter"
  type = "String"
  value = jsonencode({
    description    = "The default application-development environment to write and test algorithms before preparing them for scaled execution in the SPS. Pre-configured with authentication tokens and various python libraries to assist in using the various features of the platform."
    healthCheckUrl = "${module.frontend.jupyter_base_url}/${module.frontend.jupyter_base_path}/hub/health"
    landingPageUrl = "${module.frontend.jupyter_base_url}/${module.frontend.jupyter_base_path}/"
    componentCategory = "development"
    componentName  = "Jupyterhub"
    componentType  = "ui"
  })

  provisioner "local-exec" {
    when = destroy
    command = "${path.module}/eks_pre_destroy_actions.sh"
  }
}

data "aws_eks_cluster_auth" "eks_cluster_auth" {
  name = aws_eks_cluster.eks_cluster.name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_cluster_auth.token
}


resource "kubernetes_namespace" "wordpress" {
  metadata {
    name = "wordpress"
  }
}

data "aws_secretsmanager_secret" "rds_secret" {
  name = var.rds_secret_name
}

data "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = data.aws_secretsmanager_secret.rds_secret.id
}

resource "kubernetes_secret" "wordpress_db" {
  metadata {
    name      = "wordpress-db-credentials"
    namespace = kubernetes_namespace.wordpress.metadata[0].name
  }

  data = {
    username = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)["username"]
    password = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)["password"]
  }
}

resource "kubernetes_deployment" "wordpress" {
  metadata {
    name      = "wordpress"
    namespace = kubernetes_namespace.wordpress.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "wordpress"
      }
    }

    template {
      metadata {
        labels = {
          app = "wordpress"
        }
      }

      spec {
        container {
          name  = "wordpress"
          image = "wordpress:latest"

          env {
            name  = "WORDPRESS_DB_HOST"
            value = var.rds_endpoint
          }

          env {
            name = "WORDPRESS_DB_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.wordpress_db.metadata[0].name
                key  = "username"
              }
            }
          }

          env {
            name = "WORDPRESS_DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.wordpress_db.metadata[0].name
                key  = "password"
              }
            }
          }

          env {
            name  = "WORDPRESS_DB_NAME"
            value = "devops_rds"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "wordpress" {
  metadata {
    name      = "wordpress"
    namespace = kubernetes_namespace.wordpress.metadata[0].name
  }

  spec {
    selector = {
      app = "wordpress"
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 80
    }
  }
}

# // Create service account for Container Register and assign required roles for it
# resource "yandex_iam_service_account" "registry_sa" {
#   folder_id = var.folder_id
#   name      = "registry-sa"
# }

# resource "yandex_resourcemanager_folder_iam_member" "registry_sa_roles" {
#   folder_id = var.folder_id
#   role      = "container-registry.images.puller"
#   member    = "serviceAccount:${yandex_iam_service_account.registry_sa.id}"
# }

# resource "yandex_resourcemanager_folder_iam_member" "registry_sa_roles_pusher" {
#   folder_id = var.folder_id
#   role      = "container-registry.images.pusher"
#   member    = "serviceAccount:${yandex_iam_service_account.registry_sa.id}"
# }

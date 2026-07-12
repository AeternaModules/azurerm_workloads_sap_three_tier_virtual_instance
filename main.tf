resource "azurerm_workloads_sap_three_tier_virtual_instance" "workloads_sap_three_tier_virtual_instances" {
  for_each = var.workloads_sap_three_tier_virtual_instances

  app_location                          = each.value.app_location
  environment                           = each.value.environment
  location                              = each.value.location
  name                                  = each.value.name
  resource_group_name                   = each.value.resource_group_name
  sap_fqdn                              = each.value.sap_fqdn
  sap_product                           = each.value.sap_product
  managed_resource_group_name           = each.value.managed_resource_group_name
  managed_resources_network_access_type = each.value.managed_resources_network_access_type
  tags                                  = each.value.tags

  three_tier_configuration {
    app_resource_group_name = each.value.three_tier_configuration.app_resource_group_name
    application_server_configuration {
      instance_count = each.value.three_tier_configuration.application_server_configuration.instance_count
      subnet_id      = each.value.three_tier_configuration.application_server_configuration.subnet_id
      virtual_machine_configuration {
        image {
          offer     = each.value.three_tier_configuration.application_server_configuration.virtual_machine_configuration.image.offer
          publisher = each.value.three_tier_configuration.application_server_configuration.virtual_machine_configuration.image.publisher
          sku       = each.value.three_tier_configuration.application_server_configuration.virtual_machine_configuration.image.sku
          version   = each.value.three_tier_configuration.application_server_configuration.virtual_machine_configuration.image.version
        }
        os_profile {
          admin_username  = each.value.three_tier_configuration.application_server_configuration.virtual_machine_configuration.os_profile.admin_username
          ssh_private_key = each.value.three_tier_configuration.application_server_configuration.virtual_machine_configuration.os_profile.ssh_private_key
          ssh_public_key  = each.value.three_tier_configuration.application_server_configuration.virtual_machine_configuration.os_profile.ssh_public_key
        }
        virtual_machine_size = each.value.three_tier_configuration.application_server_configuration.virtual_machine_configuration.virtual_machine_size
      }
    }
    central_server_configuration {
      instance_count = each.value.three_tier_configuration.central_server_configuration.instance_count
      subnet_id      = each.value.three_tier_configuration.central_server_configuration.subnet_id
      virtual_machine_configuration {
        image {
          offer     = each.value.three_tier_configuration.central_server_configuration.virtual_machine_configuration.image.offer
          publisher = each.value.three_tier_configuration.central_server_configuration.virtual_machine_configuration.image.publisher
          sku       = each.value.three_tier_configuration.central_server_configuration.virtual_machine_configuration.image.sku
          version   = each.value.three_tier_configuration.central_server_configuration.virtual_machine_configuration.image.version
        }
        os_profile {
          admin_username  = each.value.three_tier_configuration.central_server_configuration.virtual_machine_configuration.os_profile.admin_username
          ssh_private_key = each.value.three_tier_configuration.central_server_configuration.virtual_machine_configuration.os_profile.ssh_private_key
          ssh_public_key  = each.value.three_tier_configuration.central_server_configuration.virtual_machine_configuration.os_profile.ssh_public_key
        }
        virtual_machine_size = each.value.three_tier_configuration.central_server_configuration.virtual_machine_configuration.virtual_machine_size
      }
    }
    database_server_configuration {
      database_type = each.value.three_tier_configuration.database_server_configuration.database_type
      dynamic "disk_volume_configuration" {
        for_each = each.value.three_tier_configuration.database_server_configuration.disk_volume_configuration != null ? each.value.three_tier_configuration.database_server_configuration.disk_volume_configuration : []
        content {
          number_of_disks = disk_volume_configuration.value.number_of_disks
          size_in_gb      = disk_volume_configuration.value.size_in_gb
          sku_name        = disk_volume_configuration.value.sku_name
          volume_name     = disk_volume_configuration.value.volume_name
        }
      }
      instance_count = each.value.three_tier_configuration.database_server_configuration.instance_count
      subnet_id      = each.value.three_tier_configuration.database_server_configuration.subnet_id
      virtual_machine_configuration {
        image {
          offer     = each.value.three_tier_configuration.database_server_configuration.virtual_machine_configuration.image.offer
          publisher = each.value.three_tier_configuration.database_server_configuration.virtual_machine_configuration.image.publisher
          sku       = each.value.three_tier_configuration.database_server_configuration.virtual_machine_configuration.image.sku
          version   = each.value.three_tier_configuration.database_server_configuration.virtual_machine_configuration.image.version
        }
        os_profile {
          admin_username  = each.value.three_tier_configuration.database_server_configuration.virtual_machine_configuration.os_profile.admin_username
          ssh_private_key = each.value.three_tier_configuration.database_server_configuration.virtual_machine_configuration.os_profile.ssh_private_key
          ssh_public_key  = each.value.three_tier_configuration.database_server_configuration.virtual_machine_configuration.os_profile.ssh_public_key
        }
        virtual_machine_size = each.value.three_tier_configuration.database_server_configuration.virtual_machine_configuration.virtual_machine_size
      }
    }
    high_availability_type = each.value.three_tier_configuration.high_availability_type
    dynamic "resource_names" {
      for_each = each.value.three_tier_configuration.resource_names != null ? [each.value.three_tier_configuration.resource_names] : []
      content {
        dynamic "application_server" {
          for_each = resource_names.value.application_server != null ? [resource_names.value.application_server] : []
          content {
            availability_set_name = application_server.value.availability_set_name
            dynamic "virtual_machine" {
              for_each = application_server.value.virtual_machine != null ? application_server.value.virtual_machine : []
              content {
                dynamic "data_disk" {
                  for_each = virtual_machine.value.data_disk != null ? virtual_machine.value.data_disk : []
                  content {
                    names       = data_disk.value.names
                    volume_name = data_disk.value.volume_name
                  }
                }
                host_name               = virtual_machine.value.host_name
                network_interface_names = virtual_machine.value.network_interface_names
                os_disk_name            = virtual_machine.value.os_disk_name
                virtual_machine_name    = virtual_machine.value.virtual_machine_name
              }
            }
          }
        }
        dynamic "central_server" {
          for_each = resource_names.value.central_server != null ? [resource_names.value.central_server] : []
          content {
            availability_set_name = central_server.value.availability_set_name
            dynamic "load_balancer" {
              for_each = central_server.value.load_balancer != null ? [central_server.value.load_balancer] : []
              content {
                backend_pool_names              = load_balancer.value.backend_pool_names
                frontend_ip_configuration_names = load_balancer.value.frontend_ip_configuration_names
                health_probe_names              = load_balancer.value.health_probe_names
                name                            = load_balancer.value.name
              }
            }
            dynamic "virtual_machine" {
              for_each = central_server.value.virtual_machine != null ? central_server.value.virtual_machine : []
              content {
                dynamic "data_disk" {
                  for_each = virtual_machine.value.data_disk != null ? virtual_machine.value.data_disk : []
                  content {
                    names       = data_disk.value.names
                    volume_name = data_disk.value.volume_name
                  }
                }
                host_name               = virtual_machine.value.host_name
                network_interface_names = virtual_machine.value.network_interface_names
                os_disk_name            = virtual_machine.value.os_disk_name
                virtual_machine_name    = virtual_machine.value.virtual_machine_name
              }
            }
          }
        }
        dynamic "database_server" {
          for_each = resource_names.value.database_server != null ? [resource_names.value.database_server] : []
          content {
            availability_set_name = database_server.value.availability_set_name
            dynamic "load_balancer" {
              for_each = database_server.value.load_balancer != null ? [database_server.value.load_balancer] : []
              content {
                backend_pool_names              = load_balancer.value.backend_pool_names
                frontend_ip_configuration_names = load_balancer.value.frontend_ip_configuration_names
                health_probe_names              = load_balancer.value.health_probe_names
                name                            = load_balancer.value.name
              }
            }
            dynamic "virtual_machine" {
              for_each = database_server.value.virtual_machine != null ? database_server.value.virtual_machine : []
              content {
                dynamic "data_disk" {
                  for_each = virtual_machine.value.data_disk != null ? virtual_machine.value.data_disk : []
                  content {
                    names       = data_disk.value.names
                    volume_name = data_disk.value.volume_name
                  }
                }
                host_name               = virtual_machine.value.host_name
                network_interface_names = virtual_machine.value.network_interface_names
                os_disk_name            = virtual_machine.value.os_disk_name
                virtual_machine_name    = virtual_machine.value.virtual_machine_name
              }
            }
          }
        }
        dynamic "shared_storage" {
          for_each = resource_names.value.shared_storage != null ? [resource_names.value.shared_storage] : []
          content {
            account_name          = shared_storage.value.account_name
            private_endpoint_name = shared_storage.value.private_endpoint_name
          }
        }
      }
    }
    secondary_ip_enabled = each.value.three_tier_configuration.secondary_ip_enabled
    dynamic "transport_create_and_mount" {
      for_each = each.value.three_tier_configuration.transport_create_and_mount != null ? [each.value.three_tier_configuration.transport_create_and_mount] : []
      content {
        resource_group_id    = transport_create_and_mount.value.resource_group_id
        storage_account_name = transport_create_and_mount.value.storage_account_name
      }
    }
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      identity_ids = identity.value.identity_ids
      type         = identity.value.type
    }
  }
}


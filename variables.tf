variable "workloads_sap_three_tier_virtual_instances" {
  description = <<EOT
Map of workloads_sap_three_tier_virtual_instances, attributes below
Required:
    - app_location
    - environment
    - location
    - name
    - resource_group_name
    - sap_fqdn
    - sap_product
    - three_tier_configuration (block):
        - app_resource_group_name (required)
        - application_server_configuration (required, block):
            - instance_count (required)
            - subnet_id (required)
            - virtual_machine_configuration (required, block):
                - image (required, block):
                    - offer (required)
                    - publisher (required)
                    - sku (required)
                    - version (required)
                - os_profile (required, block):
                    - admin_username (required)
                    - ssh_private_key (required)
                    - ssh_public_key (required)
                - virtual_machine_size (required)
        - central_server_configuration (required, block):
            - instance_count (required)
            - subnet_id (required)
            - virtual_machine_configuration (required, block):
                - image (required, block):
                    - offer (required)
                    - publisher (required)
                    - sku (required)
                    - version (required)
                - os_profile (required, block):
                    - admin_username (required)
                    - ssh_private_key (required)
                    - ssh_public_key (required)
                - virtual_machine_size (required)
        - database_server_configuration (required, block):
            - database_type (optional)
            - disk_volume_configuration (optional, block):
                - number_of_disks (required)
                - size_in_gb (required)
                - sku_name (required)
                - volume_name (required)
            - instance_count (required)
            - subnet_id (required)
            - virtual_machine_configuration (required, block):
                - image (required, block):
                    - offer (required)
                    - publisher (required)
                    - sku (required)
                    - version (required)
                - os_profile (required, block):
                    - admin_username (required)
                    - ssh_private_key (required)
                    - ssh_public_key (required)
                - virtual_machine_size (required)
        - high_availability_type (optional)
        - resource_names (optional, block):
            - application_server (optional, block):
                - availability_set_name (optional)
                - virtual_machine (optional, block):
                    - data_disk (optional, block):
                        - names (required)
                        - volume_name (required)
                    - host_name (optional)
                    - network_interface_names (optional)
                    - os_disk_name (optional)
                    - virtual_machine_name (optional)
            - central_server (optional, block):
                - availability_set_name (optional)
                - load_balancer (optional, block):
                    - backend_pool_names (optional)
                    - frontend_ip_configuration_names (optional)
                    - health_probe_names (optional)
                    - name (optional)
                - virtual_machine (optional, block):
                    - data_disk (optional, block):
                        - names (required)
                        - volume_name (required)
                    - host_name (optional)
                    - network_interface_names (optional)
                    - os_disk_name (optional)
                    - virtual_machine_name (optional)
            - database_server (optional, block):
                - availability_set_name (optional)
                - load_balancer (optional, block):
                    - backend_pool_names (optional)
                    - frontend_ip_configuration_names (optional)
                    - health_probe_names (optional)
                    - name (optional)
                - virtual_machine (optional, block):
                    - data_disk (optional, block):
                        - names (required)
                        - volume_name (required)
                    - host_name (optional)
                    - network_interface_names (optional)
                    - os_disk_name (optional)
                    - virtual_machine_name (optional)
            - shared_storage (optional, block):
                - account_name (optional)
                - private_endpoint_name (optional)
        - secondary_ip_enabled (optional)
        - transport_create_and_mount (optional, block):
            - resource_group_id (optional)
            - storage_account_name (optional)
Optional:
    - managed_resource_group_name
    - managed_resources_network_access_type
    - tags
    - identity (block):
        - identity_ids (required)
        - type (required)
EOT

  type = map(object({
    app_location                          = string
    environment                           = string
    location                              = string
    name                                  = string
    resource_group_name                   = string
    sap_fqdn                              = string
    sap_product                           = string
    managed_resource_group_name           = optional(string)
    managed_resources_network_access_type = optional(string, "Public")
    tags                                  = optional(map(string))
    three_tier_configuration = object({
      app_resource_group_name = string
      application_server_configuration = object({
        instance_count = number
        subnet_id      = string
        virtual_machine_configuration = object({
          image = object({
            offer     = string
            publisher = string
            sku       = string
            version   = string
          })
          os_profile = object({
            admin_username  = string
            ssh_private_key = string
            ssh_public_key  = string
          })
          virtual_machine_size = string
        })
      })
      central_server_configuration = object({
        instance_count = number
        subnet_id      = string
        virtual_machine_configuration = object({
          image = object({
            offer     = string
            publisher = string
            sku       = string
            version   = string
          })
          os_profile = object({
            admin_username  = string
            ssh_private_key = string
            ssh_public_key  = string
          })
          virtual_machine_size = string
        })
      })
      database_server_configuration = object({
        database_type = optional(string)
        disk_volume_configuration = optional(object({
          number_of_disks = number
          size_in_gb      = number
          sku_name        = string
          volume_name     = string
        }))
        instance_count = number
        subnet_id      = string
        virtual_machine_configuration = object({
          image = object({
            offer     = string
            publisher = string
            sku       = string
            version   = string
          })
          os_profile = object({
            admin_username  = string
            ssh_private_key = string
            ssh_public_key  = string
          })
          virtual_machine_size = string
        })
      })
      high_availability_type = optional(string)
      resource_names = optional(object({
        application_server = optional(object({
          availability_set_name = optional(string)
          virtual_machine = optional(object({
            data_disk = optional(object({
              names       = list(string)
              volume_name = string
            }))
            host_name               = optional(string)
            network_interface_names = optional(list(string))
            os_disk_name            = optional(string)
            virtual_machine_name    = optional(string)
          }))
        }))
        central_server = optional(object({
          availability_set_name = optional(string)
          load_balancer = optional(object({
            backend_pool_names              = optional(list(string))
            frontend_ip_configuration_names = optional(list(string))
            health_probe_names              = optional(list(string))
            name                            = optional(string)
          }))
          virtual_machine = optional(object({
            data_disk = optional(object({
              names       = list(string)
              volume_name = string
            }))
            host_name               = optional(string)
            network_interface_names = optional(list(string))
            os_disk_name            = optional(string)
            virtual_machine_name    = optional(string)
          }))
        }))
        database_server = optional(object({
          availability_set_name = optional(string)
          load_balancer = optional(object({
            backend_pool_names              = optional(list(string))
            frontend_ip_configuration_names = optional(list(string))
            health_probe_names              = optional(list(string))
            name                            = optional(string)
          }))
          virtual_machine = optional(object({
            data_disk = optional(object({
              names       = list(string)
              volume_name = string
            }))
            host_name               = optional(string)
            network_interface_names = optional(list(string))
            os_disk_name            = optional(string)
            virtual_machine_name    = optional(string)
          }))
        }))
        shared_storage = optional(object({
          account_name          = optional(string)
          private_endpoint_name = optional(string)
        }))
      }))
      secondary_ip_enabled = optional(bool, false)
      transport_create_and_mount = optional(object({
        resource_group_id    = optional(string)
        storage_account_name = optional(string)
      }))
    })
    identity = optional(object({
      identity_ids = set(string)
      type         = string
    }))
  }))
}


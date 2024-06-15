#!/bin/bash
# {{ ansible_managed }}

{% set netavark_path = podman_netavark_bin_dir if podman_netavark_install_method == "github"
                       else "/usr/lib/podman/" -%}

export NETAVARK_FW="{{ podman_netavark_firewall_driver }}"

{{ netavark_path }}/netavark $@

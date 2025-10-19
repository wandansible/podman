Ansible role: podman
====================

Installs podman and allows configuration of network provider,
containers.conf.d, registeries.conf.d, container hooks and libpod.

This role can optionally install updated versions of podman-compose
and netavark from github, rather than using the versions packaged for apt.

Also this role allows podman containers and networks to be configured and started.

Requirements
------------

This role requires the following collections to be installed:

  - community.general
  - containers.podman

Role Variables
--------------

```
ENTRY POINT: *main* - Install and configure podman

          Installs podman and allows configuration of network
          provider, containers.conf.d, registeries.conf.d, container
          hooks and libpod.
          This role can optionally install updated versions of
          podman-compose and netavark from github, rather than using
          the versions packaged for apt.
          Also this role allows podman containers and networks to be
          configured and started.

Options (= indicates it is required):

- podman_compose_github_org  Name of organisation for podman-compose
                              github repository
          default: containers
          type: str

- podman_compose_github_repo  Name of podman-compose github
                               repository
          default: podman-compose
          type: str

- podman_compose_github_version  Version of podman-compose to install
                                  (use "latest" for the latest
                                  version)
          default: latest
          type: str

- podman_compose_install_method  Where to install podman-compose from
          choices: [apt, github]
          default: apt
          type: str

- podman_container_hook_directory  Directory to create podman hook
                                    scripts in
          default: /usr/local/bin/podman/hooks
          type: str

- podman_container_hooks  List of podmain container hook scripts
          default: []
          elements: dict
          type: list
          options:

          = config  Configuration for podman container hook
            type: str

          = hook  Contents of podman hook script
            type: str

          = name  Name of podman container hook
            type: str

- podman_containers  List of podman containers to create
          default: []
          elements: dict
          type: list
          options:

          - add_capabilities  List of capabilities to add to the
                               container.
            default: null
            elements: str
            type: list

          - annotation  Add an annotation to the container. The
                         format is key value, multiple times.
            default: null
            type: dict

          - arch  Set the architecture for the container. Override
                   the architecture, defaults to hosts, of the image
                   to be pulled. For example, arm.
            default: null
            type: str

          - attach  Attach to STDIN, STDOUT or STDERR. The default in
                     Podman is false.
            choices: [stdin, stdout, stderr]
            default: null
            elements: str
            type: list

          - authfile  Path of the authentication file. Default is
                       ``${XDG_RUNTIME_DIR}/containers/auth.json``
                       (Not available for remote commands) You can
                       also override the default path of the
                       authentication file by setting the
                       ``REGISTRY_AUTH_FILE`` environment variable.
                       ``export REGISTRY_AUTH_FILE=path``
            default: null
            type: path

          - auto_remove  Automatically remove the container when it
                          exits. The default is false.
            default: null
            type: bool

          - auto_remove_image  After exit of the container, remove
                                the image unless another container is
                                using it. Implies --rm on the new
                                container. The default is false.
            default: null
            type: bool

          - blkio_device_weights  Block IO weight (relative device
                                   weight, format
                                   DEVICE_NAME[:]WEIGHT).
            default: null
            type: dict

          - blkio_weight  Block IO weight (relative weight) accepts a
                           weight value between 10 and 1000
            default: null
            type: int

          - cgroup_config  When running on cgroup v2, specify the
                            cgroup file to write to and its value.
            default: null
            type: dict

          - cgroup_parent  Path to cgroups under which the cgroup for
                            the container will be created. If the path
                            is not absolute, the path is considered to
                            be relative to the cgroups path of the
                            init process. Cgroups will be created if
                            they do not already exist.
            default: null
            type: path

          - cgroupns  Path to cgroups under which the cgroup for the
                       container will be created.
            default: null
            type: str

          - cgroups  Determines whether the container will create
                      CGroups. Valid values are enabled and disabled,
                      which the default being enabled. The disabled
                      option will force the container to not create
                      CGroups, and thus conflicts with CGroup options
                      cgroupns and cgroup-parent.
            default: null
            type: str

          - chrootdirs  Path to a directory inside the container that
                         is treated as a chroot directory.
            default: null
            type: str

          - cidfile  Write the container ID to the file
            default: null
            type: path

          - cmd_args  Any additional command options you want to pass
                       to podman command itself, for example
                       `--log-level=debug' or `--syslog'. This is NOT
                       command to run in container, but rather options
                       for podman itself. For container command please
                       use `command` option.
            default: null
            elements: str
            type: list

          - command  Override command of container. Can be a string
                      or a list.
            default: null
            type: raw

          - conmon_pidfile  Write the pid of the conmon process to a
                             file. conmon runs in a separate process
                             than Podman, so this is necessary when
                             using systemd to restart Podman
                             containers.
            default: null
            type: path

          - cpu_period  Limit the CPU CFS (Completely Fair Scheduler)
                         period
            default: null
            type: int

          - cpu_quota  Limit the CPU CFS (Completely Fair Scheduler)
                        quota
            default: null
            type: int

          - cpu_rt_period  Limit the CPU real-time period in
                            microseconds. Limit the container's Real
                            Time CPU usage. This flag tell the kernel
                            to restrict the container's Real Time CPU
                            usage to the period you specify.
            default: null
            type: int

          - cpu_rt_runtime  Limit the CPU real-time runtime in
                             microseconds. This flag tells the kernel
                             to limit the amount of time in a given
                             CPU period Real Time tasks may consume.
            default: null
            type: int

          - cpu_shares  CPU shares (relative weight)
            default: null
            type: int

          - cpus  Number of CPUs. The default is 0.0 which means no
                   limit.
            default: null
            type: str

          - cpuset_cpus  CPUs in which to allow execution (0-3, 0,1)
            default: null
            type: str

          - cpuset_mems  Memory nodes (MEMs) in which to allow
                          execution (0-3, 0,1). Only effective on NUMA
                          systems.
            default: null
            type: str

          - debug  Return additional information which can be helpful
                    for investigations.
            default: false
            type: bool

          - decryption_key  The "key-passphrase" to be used for
                             decryption of images. Key can point to
                             keys and/or certificates.
            default: null
            type: str

          - delete_depend  Remove selected container and recursively
                            remove all containers that depend on it.
                            Applies to "delete" command.
            default: null
            type: bool

          - delete_time  Seconds to wait before forcibly stopping the
                          container. Use -1 for infinite wait. Applies
                          to "delete" command.
            default: null
            type: str

          - delete_volumes  Remove anonymous volumes associated with
                             the container. This does not include
                             named volumes created with podman volume
                             create, or the --volume option of podman
                             run and podman create.
            default: null
            type: bool

          - detach  Run container in detach mode
            default: true
            type: bool

          - detach_keys  Override the key sequence for detaching a
                          container. Format is a single character or
                          ctrl-value
            default: null
            type: str

          - device_cgroup_rule  Add a rule to the cgroup allowed
                                 devices list. The rule is expected to
                                 be in the format specified in the
                                 Linux kernel documentation
                                 admin-guide/cgroup-v1/devices.
            default: null
            type: str

          - devices  Add a host device to the container. The format
                      is
                      <device-on-host>[:<device-on-container>][:<permissions>]
                      (e.g. device /dev/sdc:/dev/xvdc:rwm)
            default: null
            elements: str
            type: list

          - devices_read_bps  Limit read rate (bytes per second) from
                               a device (e.g. device-read-bps
                               /dev/sda:1mb)
            default: null
            elements: str
            type: list

          - devices_read_iops  Limit read rate (IO per second) from a
                                device (e.g. device-read-iops
                                /dev/sda:1000)
            default: null
            elements: str
            type: list

          - devices_write_bps  Limit write rate (bytes per second) to
                                a device (e.g. device-write-bps
                                /dev/sda:1mb)
            default: null
            elements: str
            type: list

          - devices_write_iops  Limit write rate (IO per second) to a
                                 device (e.g. device-write-iops
                                 /dev/sda:1000)
            default: null
            elements: str
            type: list

          - dns_option  Set custom DNS options
            default: null
            type: str

          - dns_resolvers  Set custom DNS servers
            default: null
            elements: str
            type: list

          - dns_search_domains  Set custom DNS search domains (Use
                                 dns_search with '' if you don't wish
                                 to set the search domain)
            default: null
            type: str

          - drop_capabilities  List of capabilities to drop from the
                                container.
            default: null
            elements: str
            type: list

          - entrypoint  Overwrite the default ENTRYPOINT of the image
            default: null
            type: str

          - env_files  Read in a line delimited file of environment
                        variables. Doesn't support idempotency. If
                        users changes the file with environment
                        variables it's on them to recreate the
                        container. The file must be present on the
                        REMOTE machine where actual podman is running,
                        not on the controller machine where Ansible is
                        executing. If you need to copy the file from
                        controller to remote machine, use the copy or
                        slurp module.
            default: null
            elements: path
            type: list

          - env_host  Use all current host environment variables in
                       container. Defaults to false.
            default: null
            type: bool

          - env_vars  Set environment variables. This option allows
                       you to specify arbitrary environment variables
                       that are available for the process that will be
                       launched inside of the container.
            default: null
            type: dict

          - env_vars_merge  Preprocess default environment variables
                             for the containers
            default: null
            type: dict

          - etc_hosts  Dict of host-to-IP mappings, where each host
                        name is a key in the dictionary. Each host
                        name will be added to the container's
                        ``/etc/hosts`` file.
            default: null
            type: dict

          - exposed_ports  Expose a port, or a range of ports (e.g.
                            expose "3300-3310") to set up port
                            redirection on the host system.
            default: null
            elements: str
            type: list

          - force_delete  Force deletion of container when it's being
                           deleted.
            default: true
            type: bool

          - force_restart  Force restart of container.
            default: false
            type: bool

          - generate_systemd  Generate systemd unit file for
                               container.
            default: {}
            type: dict
            options:

            - after  Add the systemd unit after (After=) option, that
                      ordering dependencies between the list of
                      dependencies and this service.
              default: null
              elements: str
              type: list

            - container_prefix  Set the systemd unit name prefix for
                                 containers. The default is
                                 "container".
              default: null
              type: str

            - names  Use names of the containers for the start, stop,
                      and description in the unit file. Default is
                      true.
              default: true
              type: bool

            - new  Create containers and pods when the unit is
                    started instead of expecting them to exist. The
                    default is "false". Refer to
                    podman-generate-systemd(1) for more information.
              default: false
              type: bool

            - no_header  Do not generate the header including meta
                          data such as the Podman version and the
                          timestamp. From podman version 3.1.0.
              default: false
              type: bool

            - path  Specify a path to the directory where unit files
                     will be generated. Required for this option. If
                     it doesn't exist, the directory will be created.
              default: null
              type: str

            - pod_prefix  Set the systemd unit name prefix for pods.
                           The default is "pod".
              default: null
              type: str

            - requires  Set the systemd unit requires (Requires=)
                         option. Similar to wants, but declares a
                         stronger requirement dependency.
              default: null
              elements: str
              type: list

            - restart_policy  Specify a restart policy for the
                               service.  The restart-policy must be
                               one of "no", "on-success",
                               "on-failure", "on-abnormal",
                               "on-watchdog", "on-abort", or "always".
                               The default policy is "on-failure".
              choices: ['no', on-success, on-failure, on-abnormal, on-watchdog, on-abort, always]
              default: null
              type: str

            - restart_sec  Set the systemd service restartsec value.
              default: null
              type: int

            - separator  Set the systemd unit name separator between
                          the name/id of a container/pod and the
                          prefix. The default is "-" (dash).
              default: null
              type: str

            - start_timeout  Override the default start timeout for
                              the container with the given value.
              default: null
              type: int

            - stop_timeout  Override the default stop timeout for the
                             container with the given value.
              default: null
              type: int

            - wants  Add the systemd unit wants (Wants=) option, that
                      this service is (weak) dependent on.
              default: null
              elements: str
              type: list

          - gidmap  Run the container in a new user namespace using
                     the supplied mapping.
            default: null
            elements: str
            type: list

          - gpus  GPU devices to add to the container.
            default: null
            type: str

          - group_entry  Customize the entry that is written to the
                          /etc/group file within the container when
                          --user is used.
            default: null
            type: str

          - groups  Add additional groups to run as
            default: null
            elements: str
            type: list

          - healthcheck  Set or alter a healthcheck command for a
                          container.
            default: null
            type: str

          - healthcheck_failure_action  The action to be taken when
                                         the container is considered
                                         unhealthy. The action must be
                                         one of "none", "kill",
                                         "restart", or "stop". The
                                         default policy is "none".
            choices: [none, kill, restart, stop]
            default: null
            type: str

          - healthcheck_interval  Set an interval for the
                                   healthchecks (a value of disable
                                   results in no automatic timer
                                   setup) (default "30s")
            default: null
            type: str

          - healthcheck_retries  The number of retries allowed before
                                  a healthcheck is considered to be
                                  unhealthy. The default value is 3.
            default: null
            type: int

          - healthcheck_start_period  The initialization time needed
                                       for a container to bootstrap.
                                       The value can be expressed in
                                       time format like 2m3s. The
                                       default value is 0s
            default: null
            type: str

          - healthcheck_startup_cmd  Set a startup healthcheck
                                      command for a container.
            default: null
            type: str

          - healthcheck_startup_interval  Set an interval for the
                                           startup healthcheck.
            default: null
            type: str

          - healthcheck_startup_retries  The number of attempts
                                          allowed before the startup
                                          healthcheck restarts the
                                          container. If set to 0, the
                                          container is never
                                          restarted. The default is 0.
            default: null
            type: int

          - healthcheck_startup_success  The number of successful
                                          runs required before the
                                          startup healthcheck succeeds
                                          and the regular healthcheck
                                          begins. A value of 0 means
                                          that any success begins the
                                          regular healthcheck. The
                                          default is 0.
            default: null
            type: int

          - healthcheck_startup_timeout  The maximum time a startup
                                          healthcheck command has to
                                          complete before it is marked
                                          as failed.
            default: null
            type: str

          - healthcheck_timeout  The maximum time allowed to complete
                                  the healthcheck before an interval
                                  is considered failed. Like
                                  start-period, the value can be
                                  expressed in a time format such as
                                  1m22s. The default value is 30s
            default: null
            type: str

          - hooks_dir  Each .json file in the path configures a hook
                        for Podman containers. For more details on the
                        syntax of the JSON files and the semantics of
                        hook injection, see oci-hooks(5). Can be set
                        multiple times.
            default: null
            elements: str
            type: list

          - hostname  Container host name. Sets the container host
                       name that is available inside the container.
            default: null
            type: str

          - hostuser  Add a user account to /etc/passwd from the host
                       to the container. The Username or UID must
                       exist on the host system.
            default: null
            type: str

          - http_proxy  By default proxy environment variables are
                         passed into the container if set for the
                         podman process. This can be disabled by
                         setting the http_proxy option to false. The
                         environment variables passed in include
                         http_proxy, https_proxy, ftp_proxy, no_proxy,
                         and also the upper case versions of those.
                         Defaults to true
            default: null
            type: bool

          - image  Repository path (or image name) and tag used to
                    create the container. If an image is not found,
                    the image will be pulled from the registry. If no
                    tag is included, `latest' will be used.
                    Can also be an image ID. If this is the case, the
                    image is assumed to be available locally.
            default: null
            type: str

          - image_strict  Whether to compare images in idempotency by
                           taking into account a full name with
                           registry and namespaces.
            default: false
            type: bool

          - image_volume  Tells podman how to handle the builtin
                           image volumes. The options are bind, tmpfs,
                           or ignore (default bind)
            choices: [bind, tmpfs, ignore]
            default: null
            type: str

          - init  Run an init inside the container that forwards
                   signals and reaps processes. The default is false.
            default: null
            type: bool

          - init_ctr  (Pods only). When using pods, create an init
                       style container, which is run after the infra
                       container is started but before regular pod
                       containers are started.
            choices: [once, always]
            default: null
            type: str

          - init_path  Path to the container-init binary.
            default: null
            type: str

          - interactive  Keep STDIN open even if not attached. The
                          default is false. When set to true, keep
                          stdin open even if not attached. The default
                          is false.
            default: null
            type: bool

          - ipc_mode  Default is to create a private IPC namespace
                       (POSIX SysV IPC) for the container
            default: null
            type: str

          - ipv4_address  Specify a static IP address for the
                           container, for example '10.88.64.128'. Can
                           only be used if no additional CNI networks
                           to join were specified via 'network:', and
                           if the container is not joining another
                           container's network namespace via 'network
                           container:<name|id>'. The address must be
                           within the default CNI network's pool
                           (default 10.88.0.0/16).
            default: null
            type: str

          - ipv6_address  Specify a static IPv6 address for the
                           container
            default: null
            type: str

          - kernel_memory  Kernel memory limit (format
                            <number>[<unit>], where unit = b, k, m or
                            g) Note - idempotency is supported for
                            integers only.
            default: null
            type: str

          - label_file  Read in a line delimited file of labels
            default: null
            type: str

          - labels  Add metadata to a container, pass dictionary of
                     label names and values
            default: null
            type: dict

          - log_driver  Logging driver. Used to set the log driver
                         for the container. For example log_driver
                         "k8s-file".
            choices: [k8s-file, journald, json-file]
            default: null
            type: str

          - log_level  Logging level for Podman. Log messages above
                        specified level
                        ("debug"|"info"|"warn"|"error"|"fatal"|"panic")
                        (default "error")
            choices: [debug, info, warn, error, fatal, panic]
            default: null
            type: str

          - log_options  Logging driver specific options. Used to set
                          the path to the container log file.
            default: null
            type: dict
            options:

            - max_size  Specify a max size of the log file (e.g
                         10mb).
              default: null
              type: str

            - path  Specify a path to the log file (e.g.
                     /var/log/container/mycontainer.json).
              default: null
              type: str

            - tag  Specify a custom log tag for the container.
              default: null
              type: str

          - mac_address  Specify a MAC address for the container, for
                          example '92:d0:c6:0a:29:33'. Don't forget
                          that it must be unique within one Ethernet
                          network.
            default: null
            type: str

          - memory  Memory limit (format 10k, where unit = b, k, m or
                     g) Note - idempotency is supported for integers
                     only.
            default: null
            type: str

          - memory_reservation  Memory soft limit (format 100m, where
                                 unit = b, k, m or g) Note -
                                 idempotency is supported for integers
                                 only.
            default: null
            type: str

          - memory_swap  A limit value equal to memory plus swap.
                          Must be used with the -m (--memory) flag.
                          The swap LIMIT should always be larger than
                          -m (--memory) value. By default, the swap
                          LIMIT will be set to double the value of
                          --memory Note - idempotency is supported for
                          integers only.
            default: null
            type: str

          - memory_swappiness  Tune a container's memory swappiness
                                behavior. Accepts an integer between 0
                                and 100.
            default: null
            type: int

          - mounts  Attach a filesystem mount to the container. bind
                     or tmpfs For example mount
                     "type=bind,source=/path/on/host,destination=/path/in/container"
            default: null
            elements: str
            type: list

          = name  Name of the container
            type: str

          - network_aliases  Add network-scoped alias for the
                              container. A container will only have
                              access to aliases on the first network
                              that it joins. This is a limitation that
                              will be removed in a later release.
            default: null
            elements: str
            type: list

          - network_mode  Set the Network mode for the container *
                           bridge create a network stack on the
                           default bridge * none no networking *
                           container:<name|id> reuse another
                           container's network stack * host use the
                           podman host network stack. *
                           <network-name>|<network-id> connect to a
                           user-defined network * ns:<path> path to a
                           network namespace to join * slirp4netns use
                           slirp4netns to create a user network stack.
                           This is the default for rootless containers
            default: null
            elements: str
            type: list

          - no_healthcheck  Disable any defined healthchecks for
                             container.
            default: null
            type: bool

          - no_hosts  Do not create /etc/hosts for the container
                       Default is false.
            default: null
            type: bool

          - oom_kill_disable  Whether to disable OOM Killer for the
                               container or not. Default is false.
            default: null
            type: bool

          - oom_score_adj  Tune the host's OOM preferences for
                            containers (accepts -1000 to 1000)
            default: null
            type: int

          - os  Override the OS, defaults to hosts, of the image to
                 be pulled. For example, windows.
            default: null
            type: str

          - passwd  Allow Podman to add entries to /etc/passwd and
                     /etc/group when used in conjunction with the
                     --user option. This is used to override the
                     Podman provided user setup in favor of entrypoint
                     configurations such as libnss-extrausers.
            default: null
            type: bool

          - passwd_entry  Customize the entry that is written to the
                           /etc/passwd file within the container when
                           --passwd is used.
            default: null
            type: str

          - personality  Personality sets the execution domain via
                          Linux personality(2).
            default: null
            type: str

          - pid_file  When the pidfile location is specified, the
                       container process' PID is written to the
                       pidfile.
            default: null
            type: path

          - pid_mode  Set the PID mode for the container
            default: null
            type: str

          - pids_limit  Tune the container's PIDs limit. Set -1 to
                         have unlimited PIDs for the container.
            default: null
            type: str

          - platform  Specify the platform for selecting the image.
            default: null
            type: str

          - pod  Run container in an existing pod. If you want podman
                  to make the pod for you, prefix the pod name with
                  "new:"
            default: null
            type: str

          - pod_id_file  Run container in an existing pod and read
                          the pod's ID from the specified file. When a
                          container is run within a pod which has an
                          infra-container, the infra-container starts
                          first.
            default: null
            type: path

          - preserve_fd  Pass down to the process the additional file
                          descriptors specified in the comma separated
                          list.
            default: null
            elements: str
            type: list

          - preserve_fds  Pass down to the process N additional file
                           descriptors (in addition to 0, 1, 2). The
                           total FDs are 3\+N.
            default: null
            type: str

          - privileged  Give extended privileges to this container.
                         The default is false.
            default: null
            type: bool

          - publish_all  Publish all exposed ports to random ports on
                          the host interfaces. The default is false.
            default: null
            type: bool

          - published_ports  Publish a container's port, or range of
                              ports, to the host. Format -
                              ip:hostPort:containerPortcontainerPort |
                              hostPort:containerPort | containerPort
                              In case of only containerPort is set,
                              the hostPort will chosen randomly by
                              Podman.
            default: null
            elements: str
            type: list

          - pull_policy  Pull image policy. The default is 'missing'.
            choices: [missing, always, never, newer]
            default: null
            type: str

          - quadlet_dir  Path to the directory to write quadlet file
                          in. By default, it will be set as
                          `/etc/containers/systemd/' for root user,
                          `~/.config/containers/systemd/' for non-root
                          users.
            default: null
            type: path

          - quadlet_filename  Name of quadlet file to write. By
                               default it takes `name' value.
            default: null
            type: str

          - quadlet_options  Options for the quadlet file.
            default: null
            elements: str
            type: list

          - rdt_class  Rdt-class sets the class of service (CLOS or
                        COS) for the container to run in. Requires
                        root.
            default: null
            type: str

          - read_only  Mount the container's root filesystem as read
                        only. Default is false
            default: null
            type: bool

          - read_only_tmpfs  If container is running in --read-only
                              mode, then mount a read-write tmpfs on
                              /run, /tmp, and /var/tmp. The default is
                              true
            default: null
            type: bool

          - recreate  Use with present and started states to force
                       the re-creation of an existing container.
            default: false
            type: bool

          - requires  Specify one or more requirements. A requirement
                       is a dependency container that will be started
                       before this container. Containers can be
                       specified by name or ID.
            default: null
            elements: str
            type: list

          - restart_policy  Restart policy to follow when containers
                             exit. Restart policy will not take effect
                             if a container is stopped via the podman
                             kill or podman stop commands. Valid
                             values are * no - Do not restart
                             containers on exit *
                             on-failure[:max_retries] - Restart
                             containers when they exit with a non-0
                             exit code, retrying indefinitely or until
                             the optional max_retries count is hit *
                             always - Restart containers when they
                             exit, regardless of status, retrying
                             indefinitely
            default: null
            type: str

          - restart_time  Seconds to wait before forcibly stopping
                           the container when restarting. Use -1 for
                           infinite wait. Applies to "restarted"
                           status.
            default: null
            type: str

          - retry  Number of times to retry pulling or pushing images
                    between the registry and local storage in case of
                    failure. Default is 3.
            default: null
            type: int

          - retry_delay  Duration of delay between retry attempts
                          when pulling or pushing images between the
                          registry and local storage in case of
                          failure.
            default: null
            type: str

          - rootfs  If true, the first argument refers to an exploded
                     container on the file system. The default is
                     false.
            default: null
            type: bool

          - sdnotify  Determines how to use the NOTIFY_SOCKET, as
                       passed with systemd and Type=notify. Can be
                       container, conmon, ignore.
            default: null
            type: str

          - seccomp_policy  Specify the policy to select the seccomp
                             profile.
            default: null
            type: str

          - secrets  Add the named secrets into the container. The
                      format is `secret[,opt=opt...]', see
                      documentation
                      <https://docs.podman.io/en/latest/markdown/podman-run.1.html#secret-secret-opt-opt>
                      for more details.
            default: null
            elements: str
            type: list

          - security_opts  Security Options. For example security_opt
                            "seccomp=unconfined"
            default: null
            elements: str
            type: list

          - shm_size  Size of /dev/shm. The format is <number><unit>.
                       number must be greater than 0. Unit is optional
                       and can be b (bytes), k (kilobytes),
                       m(megabytes), or g (gigabytes). If you omit the
                       unit, the system uses bytes. If you omit the
                       size entirely, the system uses 64m
            default: null
            type: str

          - shm_size_systemd  Size of systemd-specific tmpfs mounts
                               such as /run, /run/lock,
                               /var/log/journal and /tmp.
            default: null
            type: str

          - sig_proxy  Proxy signals sent to the podman run command
                        to the container process. SIGCHLD, SIGSTOP,
                        and SIGKILL are not proxied. The default is
                        true.
            default: null
            type: bool

          - state  `absent` - A container matching the specified name
                    will be stopped and removed.
                    `present` - Asserts the existence of a container
                    matching the name and any provided configuration
                    parameters. If no container matches the name, a
                    container will be created. If a container matches
                    the name but the provided configuration does not
                    match, the container will be updated, if it can
                    be. If it cannot be updated, it will be removed
                    and re-created with the requested config. Image
                    version will be taken into account when comparing
                    configuration. Use the recreate option to force
                    the re-creation of the matching container.
                    `started` - Asserts there is a running container
                    matching the name and any provided configuration.
                    If no container matches the name, a container will
                    be created and started. Use recreate to always
                    re-create a matching container, even if it is
                    running. Use force_restart to force a matching
                    container to be stopped and restarted.
                    `stopped` - Asserts that the container is first
                    `present`, and then if the container is running
                    moves it to a stopped state.
                    `created` - Asserts that the container exists with
                    given configuration. If container doesn't exist,
                    the module creates it and leaves it in 'created'
                    state. If configuration doesn't match or
                    'recreate' option is set, the container will be
                    recreated
                    `quadlet` - Write a quadlet file with the
                    specified configuration. Requires the
                    `quadlet_dir' option to be set.
            choices: [absent, present, stopped, started, created, quadlet]
            default: started
            type: str

          - stop_signal  Signal to stop a container. Default is
                          SIGTERM.
            default: null
            type: int

          - stop_time  Seconds to wait before forcibly stopping the
                        container. Use -1 for infinite wait. Applies
                        to "stopped" status.
            default: null
            type: str

          - stop_timeout  Timeout (in seconds) to stop a container.
                           Default is 10.
            default: null
            type: int

          - subgidname  Run the container in a new user namespace
                         using the map with 'name' in the /etc/subgid
                         file.
            default: null
            type: str

          - subuidname  Run the container in a new user namespace
                         using the map with 'name' in the /etc/subuid
                         file.
            default: null
            type: str

          - sysctl  Configure namespaced kernel parameters at runtime
            default: null
            type: dict

          - systemd  Run container in systemd mode. The default is
                      true.
            default: null
            type: str

          - timeout  Maximum time (in seconds) a container is allowed
                      to run before conmon sends it the kill signal.
                      By default containers run until they exit or are
                      stopped by "podman stop".
            default: null
            type: int

          - timezone  Set timezone in container. This flag takes
                       area-based timezones, GMT time, as well as
                       local, which sets the timezone in the container
                       to match the host machine. See
                       /usr/share/zoneinfo/ for valid timezones.
                       Remote connections use local containers.conf
                       for defaults.
            default: null
            type: str

          - tls_verify  Require HTTPS and verify certificates when
                         pulling images.
            default: null
            type: bool

          - tmpfs  Create a tmpfs mount. For example tmpfs "/tmp"
                    "rw,size=787448k,mode=1777"
            default: null
            type: dict

          - tty  Allocate a pseudo-TTY. The default is false.
            default: null
            type: bool

          - uidmap  Run the container in a new user namespace using
                     the supplied mapping.
            default: null
            elements: str
            type: list

          - ulimits  Ulimit options
            default: null
            elements: str
            type: list

          - umask  Set the umask inside the container. Defaults to
                    0022. Remote connections use local containers.conf
                    for defaults.
            default: null
            type: str

          - unsetenv  Unset default environment variables for the
                       container.
            default: null
            elements: str
            type: list

          - unsetenv_all  Unset all default environment variables for
                           the container.
            default: null
            type: bool

          - user  Sets the username or UID used and optionally the
                   groupname or GID for the specified command.
            default: null
            type: str

          - userns_mode  Set the user namespace mode for the
                          container. It defaults to the PODMAN_USERNS
                          environment variable. An empty value means
                          user namespaces are disabled.
            default: null
            type: str

          - uts  Set the UTS mode for the container
            default: null
            type: str

          - variant  Use VARIANT instead of the default architecture
                      variant of the container image.
            default: null
            type: str

          - volumes  Create a bind mount. If you specify, volume
                      /HOST-DIR:/CONTAINER-DIR, podman bind mounts
                      /HOST-DIR in the host to /CONTAINER-DIR in the
                      podman container.
            default: null
            elements: str
            type: list

          - volumes_from  Mount volumes from the specified
                           container(s).
            default: null
            elements: str
            type: list

          - working_dir  Working directory inside the container. The
                          default working directory for running
                          binaries within a container is the root
                          directory (/).
            default: null
            type: str

- podman_containers_conf_d  List of podman containers.conf.d
                             configuration files to create
          default: [{config: '[network]

                network_backend = "{{ podman_network_provider }}"

                default_rootless_network_cmd = "{{ podman_userspace_network_provider }}"

                ', name: network}]
          elements: dict
          type: list
          options:

          = config  Contents of the containers.conf.d configuration
                     file
            type: str

          = name  Name of the containers.conf.d configuration file
            type: str

- podman_containers_policy_config  Podman containers/policy.json
                                    configuration file contents
          default: {}
          type: dict

- podman_default_network  Configuration to override the default
                           podman network
          default: {}
          type: dict

- podman_github_token  Optional bearer token to use to authenticate
                        with api.github.com
          default: ''
          type: str

- podman_libpod_config  Podman containers/libpod.conf configuration
                         file contents, or empty string to leave file
                         as is
          default: ''
          type: str

- podman_machine_enabled  If true, install packages required for
                           podman machine
          default: false
          type: bool

- podman_machine_packages  List of packages to install when
                            podman_machine_enabled is true
          default: [qemu-kvm, qemu-utils, gvproxy]
          elements: str
          type: list

- podman_netavark_bin_dir  Directory for the netavark binaries from
                            github
          default: /usr/local/lib/podman
          type: str

- podman_netavark_firewall_driver  Netavark firewall driver to use,
                                    or empty string to use default
                                    driver
          default: ''
          type: str

- podman_netavark_github_checksum_filename  Filename for the netavark
                                             checksums file on github
          default: sha256sums.txt
          type: str

- podman_netavark_github_checksum_type  The netavark checksums file
                                         type
          default: sha256
          type: str

- podman_netavark_github_org  Name of organisation for netavark
                               github repository
          default: wandpackaging
          type: str

- podman_netavark_github_repo  Name of netavark github repository
          default: netavark
          type: str

- podman_netavark_github_version  Version of netavark to install (use
                                   "latest" for the latest version)
          default: latest
          type: str

- podman_netavark_install_method  Where to install netavark from
          choices: [apt, github]
          default: apt
          type: str

- podman_netavark_src_dir  Directory for the downloaded netavark src
                            archive from github
          default: /usr/local/src/netavark
          type: str

- podman_netavark_wrapper_dir  Directory to put netavark wrapper for
                                configuring firewall driver, or empty
                                string to disable creating wrapper
                                script
          default: /usr/local/libexec/podman/
          type: str

- podman_network_packages  Packages to install for each network
                            provider
          default: [{name: cni, packages: [containernetworking-plugins, golang-github-containernetworking-plugin-dnsname]},
            {name: pasta, packages: [passt]}, {name: netavark, packages: [aardvark-dns, iptables,
                netavark]}, {name: slirp4netns, packages: [slirp4netns]}]
          elements: dict
          type: list
          options:

          = name  Name of the network provider
            type: str

          = packages  List of packages to install
            type: list

- podman_network_provider  Network provider to use for podman
          choices: [cni, netavark]
          default: netavark
          type: str

- podman_networks  List of podman networks to create
          default: []
          elements: dict
          type: list
          options:

          - debug  Return additional information which can be helpful
                    for investigations.
            default: false
            type: bool

          - disable_dns  Disable dns plugin
            default: false
            type: bool

          - dns_resolvers  Set network-scoped DNS resolver/nameserver
                            for containers in this network. If not
                            set, the host servers from
                            /etc/resolv.conf is used.
            default: null
            elements: str
            type: list

          - driver  Driver to manage the network
            default: bridge
            type: str

          - force  Remove all containers that use the network. If the
                    container is running, it is stopped and removed.
            default: false
            type: bool

          - interface_name  Interface name which is used by the
                             driver. For bridge, it uses the bridge
                             interface name. For macvlan, it is the
                             parent device on the host (it is the same
                             as 'opts.parent')
            default: null
            type: str

          - internal  Restrict external access from this network
            default: false
            type: bool

          - ipam_driver  Set the ipam driver (IP Address Management
                          Driver) for the network. When unset podman
                          chooses an ipam driver automatically based
                          on the network driver
            choices: [host-local, dhcp, none]
            default: null
            type: str

          - ipv6  Enable IPv6 (Dual Stack) networking. You must pass
                   a IPv6 subnet. The subnet option must be used with
                   the ipv6 option. Idempotency is not supported
                   because it generates subnets randomly.
            default: null
            type: bool

          - macvlan  Create a Macvlan connection based on this device
            default: null
            type: str

          = name  Name of the network
            type: str

          - net_config  List of dictionaries with network
                         configuration. Each dictionary should contain
                         'subnet' and 'gateway' keys. 'ip_range' is
                         optional.
            default: null
            elements: dict
            type: list
            options:

            = gateway  Gateway for the subnet
              type: str

            - ip_range  Allocate container IP from range
              default: null
              type: str

            = subnet  Subnet in CIDR format
              type: str

          - opts  Add network options.
            default: null
            type: dict
            options:

            - isolate  This option isolates networks by blocking
                        traffic between those that have this option
                        enabled.
              default: null
              type: bool

            - metric  Sets the Route Metric for the default route
                       created in every container joined to this
                       network. Can only be used with the Netavark
                       network backend.
              default: null
              type: int

            - mode  This option sets the specified ip/macvlan mode on
                     the interface.
              default: null
              type: str

            - mtu  MTU size for bridge network interface.
              default: null
              type: int

            - parent  The host device which should be used for the
                       macvlan interface (it is the same as
                       'interface' in that case). Defaults to the
                       default route interface.
              default: null
              type: str

            - vlan  VLAN tag for bridge which enables vlan_filtering.
              default: null
              type: int

          - quadlet_dir  Path to the directory to write quadlet file
                          in. By default, it will be set as
                          `/etc/containers/systemd/' for root user,
                          `~/.config/containers/systemd/' for non-root
                          users.
            default: null
            type: path

          - quadlet_filename  Name of quadlet file to write. By
                               default it takes `name` value.
            default: null
            type: str

          - quadlet_options  Options for the quadlet file.
            default: null
            elements: str
            type: list

          - recreate  Recreate network even if exists.
            default: false
            type: bool

          - routes  A list of static route in the format <destination
                     in CIDR notation>,<gateway>,<route metric
                     (optional)>. This route will be added to every
                     container in this network.
            default: null
            elements: str
            type: list

          - state  State of network.
            choices: [present, absent, quadlet]
            default: present
            type: str

- podman_packages  List of packages to install
          default: [catatonit, podman, podman-compose, uidmap]
          elements: str
          type: list

- podman_provides_docker  If true, install podman-docker wrapper and
                           symlink docker-compose to podman-compose
          default: false
          type: bool

- podman_registries_conf_d  List of podman registeries.conf.d
                             configuration files to create
          default: [{config: "unqualified-search-registries = [\n{% for registry in podman_unqualified_search_registries
                %}\n  \"{{ registry }}\",\n{% endfor %}\n]\n", name: unqualified-search}]
          elements: dict
          type: list
          options:

          = config  Contents of the registeries.conf.d configuration
                     file
            type: str

          = name  Name of the registeries.conf.d configuration file
            type: str

- podman_unqualified_search_registries  List of unqualified podman
                                         registeries to use for
                                         pulling images
          default: []
          elements: str
          type: list

- podman_userspace_network_provider  Userspace network provider to
                                      use for podman
          choices: [pasta, slirp4netns]
          default: slirp4netns
          type: str
```

Installation
------------

This role can either be installed manually with the ansible-galaxy CLI tool:

    ansible-galaxy collection install community.general
    ansible-galaxy collection install containers.podman
    ansible-galaxy install git+https://github.com/wandansible/podman,main,wandansible.podman

Or, by adding the following to `requirements.yml`:

    roles:
      - name: wandansible.podman
        src: https://github.com/wandansible/podman

    collections:
      - name: community.general
      - name: containers.podman

Roles listed in `requirements.yml` can be installed with the following ansible-galaxy command:

    ansible-galaxy install -r requirements.yml

Example Playbook
----------------

    - hosts: all
      roles:
         - role: wandansible.podman
           become: true
           vars:
             podman_compose_install_method: github
             podman_netavark_install_method: github

             podman_userspace_network_provider: pasta

             podman_netavark_firewall_driver: nftables

             podman_provides_docker: true

             podman_containers_conf_d:
               - name: engine
                 config: |
                   [engine]
                   hooks_dir = ["/etc/containers/oci/hooks.d"]
                   pull_policy = "newer"
                   helper_binaries_dir = [
                     "/usr/local/libexec/podman",
                     "/usr/local/lib/podman",
                     "/usr/libexec/podman",
                     "/usr/lib/podman",
                     "/usr/bin/",
                   ]

             podman_default_network:
               driver: bridge
               network_interface: podman0
               subnets:
                 - subnet: 192.0.2.2/24
                   gateway: 192.0.2.254/24
                 - subnet: 2001:db8::2/64
                   gateway: 2001:db8::1/64
               ipv6_enabled: true
               internal: false
               dns_enabled: true
               ipam_options:
                 driver: host-local

             podman_unqualified_search_registries:
               - docker.io
               - ghcr.io
               - quay.io

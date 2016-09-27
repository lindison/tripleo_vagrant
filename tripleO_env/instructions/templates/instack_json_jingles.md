##Copy and paste from jq . to the end of the doc into the console of undercloud as user stack.

jq . << EOF > ~/instackenvjingles.json
{
  "ssh-user": "root",
  "ssh-key": "$(cat ~/.ssh/id_rsa)",
  "power_manager": "nova.virt.baremetal.virtual_power_driver.VirtualPowerManager",
  "host-ip": "192.168.10.207",
  "arch": "x86_64",
  "nodes": [
    {
      "pm_addr": "192.168.10.207",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 1p /tmp/jingles_nodes.txt)"
      ],
      "cpu": "1",
      "memory": "2048",
      "disk": "100",
      "arch": "x86_64",
      "pm_user": "root"
    },
    {
      "pm_addr": "192.168.10.207",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 2p /tmp/jingles_nodes.txt)"
      ],
      "cpu": "1",
      "memory": "2048",
      "disk": "100",
      "arch": "x86_64",
      "pm_user": "root"
    },
    {
      "pm_addr": "192.168.10.207",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 3p /tmp/jingles_nodes.txt)"
      ],
      "cpu": "1",
      "memory": "2048",
      "disk": "100",
      "arch": "x86_64",
      "pm_user": "root"
    },
    {
      "pm_addr": "192.168.10.207",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 4p /tmp/jingles_nodes.txt)"
      ],
      "cpu": "1",
      "memory": "2048",
      "disk": "100",
      "arch": "x86_64",
      "pm_user": "root"
    },
    {
      "pm_addr": "192.168.10.207",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 5p /tmp/jingles_nodes.txt)"
      ],
      "cpu": "1",
      "memory": "2048",
      "disk": "100",
      "arch": "x86_64",
      "pm_user": "root"
    }
  ]
}
EOF

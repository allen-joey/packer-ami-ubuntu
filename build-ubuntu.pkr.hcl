# build-ubuntu.pkr.hcl, run the latest updates.

build {
  sources = [
    "source.amazon-ebs.ubuntu-ami"
  ]

  provisioner "shell" {
    inline = [
      "cloud-init status --wait",
      "sudo apt-get update && sudo apt-get upgrade -y"
    ]
  }
}
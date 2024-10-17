# Optimized Packer Ubuntu AMI Build

This is a [packer](https://packer.io) build for creating an optimized AMI.
It will create a private Ubuntu Jammy-22.04 AMI in whatever account you are running it in.

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/allen-joey/packer-ami-ubuntu.git
   ```
2. [Install Packer](https://www.packer.io/docs/install)

## Instructions

```
Setup AWS CLI Credentials
Set the environment vaiables: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
```

```
REGION = EU-WEST-2 (example)
```

### Creating AMI

The AMI is created using packer.

1. Update the default values of base_ami, subnet_id (with internet access) and security_group_id (allow port 22 from local ip) in the variables.pkr.hcl to match the ones in your AWS account.
3. cd into the project folder in the cloned repository.
4. Run the following commands in order
    - packer init .
    - packer fmt .
    - packer validate . or packer-fmt-validate.sh script
    - packer build . or packer-build.sh script

This will provision the AMI in you AWS account.

Now, you can use the AMI to launch an EC2 instance which will have the web application pre configured and ready to use.

## Configuration

All configuration variables are defined and documented
in the file: `./variables.pkr.hcl`. This is also where some defaults are defined.

Optional, variables can be set in `./release.auto.pkrvars.hcl` or `./overrides.auto.pkrvars.hcl`.

#### Overrides

If you would like to override any of the defaults provided here without committing any changes to git, you
can use the `overrides.auto.pkrvars.hcl` file, which is ignored by source control.

For example, if you want your AMI to have a smaller root block device, you can override the default value
of 30 GB like this:

```
export REGION=eu-west-2
echo "block_device_size_gb = 8" > ./overrides.auto.pkrvars.hcl

```

## Cleanup

1. Deregister the AMI from EC2 Images via cli or console.
2. Delete the snapshot from EC2 EBS via cli or console.

First get the shapshot id using describe-images:

```
aws ec2 describe-images --image-ids ami-0123456789
```

Then deregister the image and delete the snapshot:

```
aws ec2 deregister-image --image-id ami-0123456789
aws ec2 delete-snapshot --snapshot-id snap-9876543210
```

## IAM Permissions

For details on the minimum IAM permissions required to build the AMI, see the
packer docs.

## License
[MIT](https://choosealicense.com/licenses/mit/)

## Author Information

Joey Allen
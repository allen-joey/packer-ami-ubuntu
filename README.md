# Optimized Packer AMI Build

This is a [packer](https://packer.io) build for creating an optimized AMI.
It will create a private Ubuntu Jammy-22.04 AMI in whatever account you are running it in.

## Instructions

```
Setup AWS CLI Credentials
```

```
REGION = EU-WEST-2
```

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

For details on the minimum IAM permissions required to build the AMI, please see the
packer docs: [packer] (https://www.packer.io/docs/builders/amazon#iam-task-or-instance-role)

## License
[MIT](https://choosealicense.com/licenses/mit/)

## Author Information

Joey Allen
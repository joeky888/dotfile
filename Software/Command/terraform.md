Init
=====
* $ cd project && terraform init

Apply
=====
```sh
env=dev
terraform get -update=true
terraform init
terraform plan -var-file=config/${env}.tfvars
terraform apply -var-file=config/${env}.tfvars
```

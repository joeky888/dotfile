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
TF_LOG=DEBUG terraform apply -var-file=config/${env}.tfvars # Verbose mode
```

Destroy
=====
* Destroy everything
* $ terraform destroy
* Destroy a module
* $ terraform destroy -target module.nameOfTheModule

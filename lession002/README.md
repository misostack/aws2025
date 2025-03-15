# Lession 002

Today, we talk about Terraform module, a stack of .tf files or the way to reuse the same infrastructure components.

A typical module can look like this:

```sh
main.tf
outputs.tf
variables.tf
README.md
```

## Terminologies

> Resource : a pieces of infrastructure that is going to be created (such as VPC, a subnet, an ec2 instance)

> Module : a collection of resources that are used together to achieve a reusable use case

- We have two types of modules: root module and child module or published module and local module

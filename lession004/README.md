# Lession 004: ECS

```sh
aws ecr get-login-password --profile jsbase --region us-east-1 | docker login --username AWS --password-stdin 891377131917.dkr.ecr.us-east-1.amazonaws.com/jsbase
docker build -t expressjs_api api
docker tag jsbase:latest 891377131917.dkr.ecr.us-east-1.amazonaws.com/jsbase:latest
docker push 891377131917.dkr.ecr.us-east-1.amazonaws.com/jsbase:latest
```

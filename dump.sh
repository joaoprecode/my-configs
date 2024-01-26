 #!/bin/sh

#acessa a conexão ssh
ssh -i ./portaldoseller-cloudster.pem ubuntu@34.200.232.237
#realiza o import dos dados do banco mongo
mongodump mongodump "mongodb://master:m9UBNsBf5et2Tj@docdb-prd.cluster-c1hdn96rchwy.us-east-1.docdb.ama
zonaws.com:27017" --username master --password m9UBNsBf5et2Tj
#copia do servidor ssh para o seu armazenamento
scp -i ./portaldoseller-cloudster.pem -r -P 22 ubuntu@34.200.232.237:/home/ubuntu/dump /home/cruzbs/portal-seller/production
#restaura no lugar onde você quiser
mongorestore --uri="mongodb+srv://portaldoseller:24zCXxhjCkVIKi13@homologacaoecommerce.lv2nhra.mongodb.net/portal-ecommerce" --nsInclude=portal-ecommerce.* --verbose ./dump/portal-ecommerce

mongodump --ssl --host="docdb-prd.cluster-c1hdn96rchwy.us-east-1.docdb.amazonaws.com:27017" --db=portal-ecommerce --out=dump --username=master --password=m9UBNsBf5et2Tj

mongosh "mongodb://master:m9UBNsBf5et2Tj@docdb-prd.cluster-c1hdn96rchwy.us-east-1.docdb.amazonaws.com:27017" --username master --password m9UBNsBf5et2Tj

mongorestore --uri="mongodb+srv://portaldoseller:24zCXxhjCkVIKi13@homologacaoecommerce.lv2nhra.mongodb.net/portal-ecommerce" --nsInclude=portal-ecommerce.* --verbose ./production/dump/portal-ecommerce
mongorestore --uri="mongodb://172.31.96.172:27017/portal-ecommerce?retryWrites=false&loadBalanced=false&serverSelectionTimeoutMS=5000&connectTimeoutMS=10000" --nsInclude=portal-ecommerce.* --verbose ./dump/portal-ecommerce

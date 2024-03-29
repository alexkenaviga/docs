# --- DOCKER ---
docker kill $(docker ps -q) #kill all containers
docker rm $(docker ps -a -q) #remove all containers
docker rmi $(docker images -q) #remove all images
docker image prune #remove unused images

# --- OPENSHIFT ---
#login on openshift
oc login
#switch project
oc project dxl-dev-infra
#switch project
oc tag myvf-dxl-journey-messages:latest myvf-dxl-journey-messages:stable
#export configuration
oc export  configmap journey-spring-boot-service > file.yml

# --- KIND ---
#create cluster from config
kind create cluster --name local-alelon-ha --config ha-config.yaml
#delete clister
kind delete cluster --name local-alelon-ha
#get clusters
kind get clusters

# --- MONGO ---
#connect to db with user and pwd
mongo mongodb -u mongouser -p mongouser
#connect to remote replica set
mongo "mongodb://tableauUsr:rmdashboard@10.70.1.125:27017,10.70.1.125:27017,10.70.1.125:27017/?replicaSet=rm-mongo-rs"
#in mongo:
#change query size
DBQuery.shellBatchSize = 10000
#rotate logs
#connect to mongo and run: 
db.adminCommand( { logRotate : 1 } )
#dump and restore from zip
mongodump -d rm-mongo-db --excludeCollection=user --archive=./export/rm-mongo-db.zip
mongorestore --archive=export/rm-mongo-db.zip #Optionally for rename: --nsFrom "rm-mongo-db.*" --nsTo "test-restore.*"

# --- REDIS ---
#connect to redis from pod'sterminal
redis-cli -a redispass 

# --- AWS ---
# token mfa configuration
aws-mfa --device arn:aws:iam::184350101696:mfa/AlessandroLongo --profile engie
# list buckets
aws s3api list-buckets --profile engie
# list lambda
aws lambda list-functions --profile engie
# codecommit links
https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-https-unixes.html
https://docs.aws.amazon.com/codecommit/latest/userguide/troubleshooting-ch.html#troubleshooting-macoshttps #in case of expiring credentials

# --- JQ ---
cat ~/Desktop/management-console-prod.json | jq '.[] | select(.privateInstanceId.clientID=="6002") | select(.privateInstanceId.microserviceVersion=="v1") | select(.privateInstanceId.microservice=="productactivation")'
cat ~/Desktop/management-console-prod.json | jq '.[] | select(.privateInstanceId.operation|test("products-catalog."))'

# --- OPENSSL ---
# get `pem` name and expiration date
openssl x509 -noout -subject -enddate -in /etc/vsftpd/vsftpd.pem

# --- KAFKA ---
#delete topic
./kafka-topics.sh --bootstrap-server localhost:9092 --delete --topic compressed-sales



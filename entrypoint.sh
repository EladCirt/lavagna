#!/bin/sh

state=0
while [ $state -eq 0 ]; do
# nc -z -v db:3306;
nc -z -v elad-lavgna-db.cwkumi4ykhce.us-east-1.rds.amazonaws.com; 
if [ $? -eq 0 ];then
state=1;
else
echo "Wait for mysql"
sleep 3;
fi;
done; 

java -Xms64m -Xmx128m -Ddatasource.dialect="${DB_DIALECT}" \
-Ddatasource.url="${DB_URL}" \
-Ddatasource.username="${DB_USER}" \
-Ddatasource.password="${DB_PASS}" \
-Dspring.profiles.active="${SPRING_PROFILE}" \
-jar ./lavagna-jetty-console.war --headless
# sleep 9999
# java -Ddatasource.dialect=MYSQL 
# - Ddatasource.url=jdbc:mysql://db:3306/lavagna 
# -Ddatasource.username=sa 
# -Ddatasource.password=1234 
# -Dspring.profile.active=dev 
# -jar /app/lavagna-jetty-console.war --headless
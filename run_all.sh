echo "Vapor"
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8085/simple
sleep 10
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8085/json
sleep 10
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8085/static.html
sleep 10

echo "Node"
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8086/simple
sleep 10
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8086/json
sleep 10
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8086/static.html
sleep 10

echo "Spring Boot"
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8087/simple
sleep 10
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8087/json
sleep 10
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8087/static.html
sleep 10

echo "Gin"
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8088/simple
sleep 10
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8088/json
sleep 10
wrk -d 10m -t 4 -c 50 http://169.254.238.54:8088/static.html
sleep 10

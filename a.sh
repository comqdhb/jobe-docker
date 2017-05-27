export ipadr=`hostname --all-ip-addresses |awk '{print $1}'`
export jobeTag=jobe:v001
sudo docker build --cap-add=NET_ADMIN  -t jobe:v001 .
sudo cp jobe.service /etc/systemd/system/jobe.service
sudo systemctl daemon-reload
sudo systemctl start jobe

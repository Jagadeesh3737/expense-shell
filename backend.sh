echo -e "\e[31m disabling nodejs \e[0m"
dnf module disable nodejs -y

echo -e '\e[31m enabling nodejs:18 \e[0m'
dnf module enable nodejs:18 -y

echo -e "\e[31m installing nodejs \e[0m"
dnf install nodejs -y

echo -e "\e[31m copying backend.service \e[0m"
cp backend.service /etc/systemd/system/backend.service


echo -e "\e[34m adding user "expense" \e[0m"
useradd expense

echo -e "\e[35m making directory 'app' \e[0m"
mkdir /app

echo -e "\e[36m downloading the backend application code \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip

echo -e "\e[33m unzipping the backend code \e[0m"
unzip /tmp/backend.zip

cd /app

echo -e "\e[35m installing dependencies \e[0m"
npm install

echo -e "\e[34m installing mysql client \e[0m"
dnf install mysql -y

echo -e "\e[35m LOADING SCHEMA \e[0"
mysql -y mysql-dev.devops76.online -uroot -pExpenseApp@1 < /app/schema/backend.sql

echo -e "\e[34m reloading the system to detect the new service \e[0m"
systemctl daemon-reload
echo -e "\e[32m enabling backend \e[0"
systemctl enable backend
echo -e "\e[31m starting backend service \e[0m"
systemctl start backend



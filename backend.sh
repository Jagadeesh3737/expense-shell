log_file=/tmp/expense.log
color="\e[31m"

echo -e "${color} disabling nodejs \e[0m"
dnf module disable nodejs -y &>>log_file
if [ $? -eq 0 ]; then
     echo -e "\e[32m success \e[0m"
else
     echo -e"\e[31m failure \e[0m"
fi


echo -e "${color} enabling nodejs:18 \e[0m"
dnf module enable nodejs:18 -y &>>log_file
if [ $? -eq 0 ]; then
     echo -e "\e[32m success \e[0m"
else
     echo -e"\e[31m failure \e[0m"
fi


echo -e "${color} installing nodejs \e[0m"
dnf install nodejs -y &>>log_file
if [ $? -eq 0 ]; then
     echo -e "\e[32m success \e[0m"
else
     echo -e"\e[31m failure \e[0m"
fi


echo -e "${color} copying backend.service \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>log_file
if [ $? -eq 0 ]; then
     echo -e "\e[32m success \e[0m"
else
     echo -e"\e[31m failure \e[0m"
fi


id expense &>>$log_file
if [ $? -ne 0 ]; then
  echo -e "${color} adding user "expense" \e[0m"
    useradd expense &>>log_file
      if [ $? -eq 0 ]; then
        echo -e "\e[32 success \e[0m"
      else
        echo -e "\e[31m failure \e[0m"
      fi
fi

if [ ! -d /app ]; then
   echo -e "${color} making directory 'app' \e[0m"
   mkdir /app &>>log_file
      if [ $? -eq 0 ]; then
        echo -e "\e[32m success \e[0m"
      else
        echo -e "\e[31m failure \e[0m"
      fi
fi

cd /app &>>log_file
  if [ $? -eq 0 ]; then
       echo -e "\e[32m success \e[0m"
  else
       echo -e"\e[31m failure \e[0m"
  fi

echo -e "${color} downloading the backend application code \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
if [ $? -eq 0 ]; then
     echo -e "\e[32m success \e[0m"
else
     echo -e"\e[31m failure \e[0m"
fi

echo -e "${color} unzipping the backend code \e[0m"
unzip /tmp/backend.zip
if [ $? -eq 0 ]; then
  echo -e "\e[32m success \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi

echo -e "${color} installing dependencies \e[0m"
npm install &>>log_file
if [ $? -eq 0 ]; then
     echo -e "\e[32m success \e[0m"
else
     echo -e"\e[31m failure \e[0m"
fi


echo -e "${color} installing mysql client \e[0m"
dnf install mysql -y &>>log_file
if [ $? -eq 0 ]; then
     echo -e "\e[32m success \e[0m"
else
     echo -e"\e[31m failure \e[0m"
fi


echo -e "${color} LOADING SCHEMA \e[0"
mysql -h mysql-dev.devops76.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file
if [ $? -eq 0 ]; then
     echo -e "\e[32m success \e[0m"
else
     echo -e"\e[31m failure \e[0m"
fi

echo -e "${color} reloading the system to detect the new service \e[0m"
systemctl daemon-reload &>>log_file
if [ $? -eq 0 ]; then
     echo -e "\e[32m success \e[0m"
else
     echo -e"\e[31m failure \e[0m"
fi

echo -e "${color} enabling backend \e[0"
systemctl enable backend &>>log_file
if [ $? -eq 0 ]; then
     echo -e "\e[32m success \e[0m"
else
     echo -e"\e[31m failure \e[0m"
fi

echo -e "${color} starting backend service \e[0m"
systemctl start backend &>>log_file
if [ $? -eq 0 ]; then
     echo -e "\e[32m success \e[0m"
else
     echo -e"\e[31m failure \e[0m"
fi



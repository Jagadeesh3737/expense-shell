echo -e "\e[31m installing nginx \e[0m"
dnf install nginx -y &>>/tmp/expense.log


echo -e "\e[31m enabling nginx \e[0m"
systemctl enable nginx &>>/tmp/expense.log


echo -e "\e[31m starting nginx \e[0m"
systemctl start nginx &>>/tmp/expense.log


echo -e "\e[31m removing default content \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log


echo -e "\e[31m coopying the expense.conf \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log


echo -e "\e[31m downloading the frontend application code \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/expense.log


cd /usr/share/nginx/html

echo -e "\e[31m unzipping the frontend content \e[0m"
unzip /tmp/frontend.zip &>>/tmp/expense.log


echo -e "\e[31m restarting nginx \e[0m"
systemctl restart nginx &>>/tmp/expense.log
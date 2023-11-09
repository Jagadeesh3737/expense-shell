log_file=/tmp/expense.log
color="\e[35m"


echo -e "${color} disabling mysql \e[0m"
dnf module disable mysql -y &>>$log_file
echo $?

echo -e "${color} copying mysql.repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
echo $?

echo -e "${color} installing mysql community server \e[0m"
dnf install mysql-community-server -y &>>$log_file
echo $?

echo -e "${color} enabling mysql \e[0m"
systemctl enable mysqld &>>$log_file
echo $?

echo -e "${color} starting mysql server \e[0m"
systemctl start mysqld &>>$log_file
echo $?

echo -e "${color} setting pass for access the service"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
echo $?
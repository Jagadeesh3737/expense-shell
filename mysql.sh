echo -e "\e[31m disabling mysql \e[0m"
dnf module disable mysql -y

echo -e "\e[31 copying mysql.repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e installing mysql community server \e[0m"
dnf install mysql-community-server -y

echo -e "\e[31m enabling mysql \e[0m"
systemctl enable mysqld

echo -e "\e[31m starting mysql server \e[0m"
systemctl start mysqld

echo -e "\e[31m setting pass for access the service"
mysql_secure_installation --set-root-pass ExpenseApp@1
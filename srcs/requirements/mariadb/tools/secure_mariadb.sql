-- Set the root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

-- Remove anonymous users
DROP USER IF EXISTS ''@'localhost';

-- Disallow root login remotely
-- DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Drop the test database
DROP DATABASE IF EXISTS test;

-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS `$DB_NAME`;

-- Create user if it doesn't exist
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';

-- Grant all privileges on the database to the user
GRANT ALL PRIVILEGES ON `$DB_NAME`.* TO '$MYSQL_USER'@'%';

-- Flush privileges to apply the changes
FLUSH PRIVILEGES;


CREATE DATABASE IF NOT EXISTS despachodb;
CREATE USER IF NOT EXISTS 'despachos_user'@'%' IDENTIFIED BY 'despachos_pass';
GRANT ALL PRIVILEGES ON despachodb.* TO 'despachos_user'@'%';

CREATE DATABASE IF NOT EXISTS ventasdb;
CREATE USER IF NOT EXISTS 'ventas_user'@'%' IDENTIFIED BY 'ventas_pass';
GRANT ALL PRIVILEGES ON ventasdb.* TO 'ventas_user'@'%';

FLUSH PRIVILEGES;
-- Usuario con permisos limitado
-- Practicante de la sección A, número 1
CREATE USER 'P-A001'@'localhost' IDENTIFIED BY 'PA1-NEW';

-- asignamos permisos
GRANT SELECT, INSERT, UPDATE ON sic_parvis_magna_gym.* TO 'P-A001'@'localhost';

-- ver privilegios
SHOW GRANTS FOR 'P-A001'@'localhost';

-- Usuario ADMIN

CREATE USER 'admin_gym'@'localhost' IDENTIFIED BY 'AdminGym#2026';
GRANT ALL PRIVILEGES ON sic_parvis_magna_gym.* TO 'admin_gym'@'localhost' WITH GRANT OPTION;

-- asignar permisos especificos
GRANT SELECT, INSERT ON sic_parvis_magna_gym.socios TO 'P-A001'@'localhost';

-- privilegios sobre columnas
GRANT SELECT (nombres, apellidos) ON sic_parvis_magna_gym.socios TO 'P-A001'@'localhost';
GRANT UPDATE (telefono) ON sic_parvis_magna_gym.socios TO 'P-A001'@'localhost';

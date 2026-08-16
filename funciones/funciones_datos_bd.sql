USE sic_parvis_magna_gym;

-- devuelve el nombre completo de un socio consultando la tabla socios
DELIMITER //
CREATE FUNCTION fn_nombre_completo_socio(p_socio_id INT)
RETURNS VARCHAR(101)
READS SQL DATA
BEGIN
    DECLARE v_nombre_completo VARCHAR(101);

    SELECT CONCAT(nombres, ' ', apellidos) 
        INTO v_nombre_completo
            FROM socios
    WHERE socio_id = p_socio_id;

    RETURN v_nombre_completo;
END//
DELIMITER ;
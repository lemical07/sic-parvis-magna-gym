USE sic_parvis_magna_gym;

-- no determinística: usa NOW(), da un resultado distinto cada vez que se llama
DELIMITER //
CREATE FUNCTION fn_marca_tiempo_reporte()
RETURNS VARCHAR(40)
NOT DETERMINISTIC
BEGIN
    RETURN CONCAT('Reporte generado: ', NOW());
END //
DELIMITER ;
USE sic_parvis_magna_gym;

-- suma la comisión de un entrenador simulando N asignaciones del mismo plan
DELIMITER //
CREATE FUNCTION fn_comision_acumulada(p_precio DECIMAL(8,2), p_porcentaje DECIMAL(4,2), p_veces INT)
RETURNS DECIMAL(8,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(8,2) DEFAULT 0;
    DECLARE v_contador INT DEFAULT 0;

    WHILE v_contador < p_veces DO
        SET v_total = v_total + (p_precio * p_porcentaje);
        SET v_contador = v_contador + 1;
    END WHILE;

    RETURN v_total;
END//
DELIMITER ;
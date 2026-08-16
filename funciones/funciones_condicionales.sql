USE sic_parvis_magna_gym;

-- clasificar un plan de entrenamiento según su precio
DELIMITER //
CREATE FUNCTION fn_categoria_plan(p_plan_id VARCHAR(5))
RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
    DECLARE v_precio DECIMAL(8,2);
    DECLARE v_categoria VARCHAR(20);

    SELECT precio 
        INTO v_precio
            FROM planes_entrenamiento
    WHERE plan_entrenamiento_id = p_plan_id;

    IF v_precio < 260 THEN
        SET v_categoria = 'Económico';
    ELSEIF v_precio BETWEEN 260 AND 320 THEN
        SET v_categoria = 'Estándar';
    ELSE
        SET v_categoria = 'Premium';
    END IF;

    RETURN v_categoria;
END//
DELIMITER ;
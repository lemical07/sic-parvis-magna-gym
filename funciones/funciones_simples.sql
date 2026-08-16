USE sic_parvis_magna_gym;

-- ---------------------------------------------------------
-- calcula un monto con IVA incluido (12%)
-- ---------------------------------------------------------
DELIMITER //
CREATE FUNCTION fn_calcular_precio_con_iva(p_monto DECIMAL(8,2))
RETURNS DECIMAL(8,2)
DETERMINISTIC
BEGIN
    RETURN p_monto * 1.12;
END //
DELIMITER ;

-- ---------------------------------------------------------
-- CALCULAR COMISION ENTRENADOR
-- comision = precio del plan x porcentaje de comisión del entrenador
-- ---------------------------------------------------------
DELIMITER //
CREATE FUNCTION fn_calcular_comision_entrenador(p_entrenador_id VARCHAR(5), p_plan_id VARCHAR(5))
RETURNS DECIMAL(8,2)
READS SQL DATA
BEGIN
    DECLARE v_precio DECIMAL(8,2);
    DECLARE v_porcentaje DECIMAL(4,2);

    SELECT precio 
        INTO v_precio
            FROM planes_entrenamiento
    WHERE plan_entrenamiento_id = p_plan_id;

    SELECT porcentaje_comision 
        INTO v_porcentaje
            FROM entrenadores
    WHERE entrenador_id = p_entrenador_id;

    RETURN v_precio * v_porcentaje;
END //
DELIMITER ;
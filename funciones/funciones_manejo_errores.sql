USE sic_parvis_magna_gym;

-- division segura: si el denominador es 0, devuelve NULL en vez de fallar
DELIMITER //
CREATE FUNCTION fn_dividir_seguro(p_numerador DECIMAL(8,2), p_denominador DECIMAL(8,2))
RETURNS DECIMAL(8,2)
DETERMINISTIC
BEGIN
    DECLARE v_resultado DECIMAL(8,2);
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET v_resultado = NULL;

    IF p_denominador = 0 THEN
        RETURN NULL;
    END IF;

    SET v_resultado = p_numerador / p_denominador;
    RETURN v_resultado;
END//
DELIMITER ;
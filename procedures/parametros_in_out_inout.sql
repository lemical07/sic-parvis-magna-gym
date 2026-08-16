USE sic_parvis_magna_gym;

-- ---------------------------------------------------------
-- OUT -devuelve cuantos planes activos tiene un socio
-- ---------------------------------------------------------
DELIMITER //

CREATE PROCEDURE sp_contar_planes_activos_socio(
    IN p_socio_id INT,
    OUT p_total_planes INT
)
BEGIN
    SELECT COUNT(*) 
        INTO p_total_planes
        FROM socio_plan_entrenamiento
    WHERE socio_id = p_socio_id AND estado = 'Activo';
END //
DELIMITER ;

-- ---------------------------------------------------------
-- INOUT -aplica un descuento sobre un precio y lo modifica directamente
-- ---------------------------------------------------------
DELIMITER //
CREATE PROCEDURE sp_aplicar_descuento(
    INOUT p_precio DECIMAL(8,2),
    IN p_porcentaje_descuento DECIMAL(4,2)
)
BEGIN
    SET p_precio = p_precio - (p_precio * p_porcentaje_descuento);
END //
DELIMITER ;

-- ---------------------------------------------------------
-- Inserción -registra un nuevo socio desde un procedimiento
-- ---------------------------------------------------------
DELIMITER  //
CREATE PROCEDURE sp_registrar_socio(
    IN p_socio_id INT,
    IN p_nombres VARCHAR(50),
    IN p_apellidos VARCHAR(50),
    IN p_telefono VARCHAR(15)
)
BEGIN
    INSERT INTO 
        socios (socio_id, nombres, apellidos, telefono)
    VALUES 
        (p_socio_id, p_nombres, p_apellidos, p_telefono);
END //
DELIMITER ;

-- ---------------------------------------------------------
-- IF_THEN_ELSE -clasifica un plan de entrenamiento segun su precio
-- ---------------------------------------------------------
DELIMITER //
CREATE PROCEDURE sp_clasificar_plan(
    IN p_plan_id VARCHAR(5),
    OUT p_categoria VARCHAR(20)
)
BEGIN
    DECLARE v_precio DECIMAL(8,2);
    SELECT precio 
        INTO v_precio
        FROM planes_entrenamiento
    WHERE plan_entrenamiento_id = p_plan_id;

    IF v_precio < 260 THEN
        SET p_categoria = 'Económico';
    ELSEIF v_precio 
        BETWEEN 260 AND 320 THEN
        SET p_categoria = 'Estándar';
    ELSE
        SET p_categoria = 'Premium';
    END IF;
END //
DELIMITER ;
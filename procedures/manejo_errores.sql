USE sic_parvis_magna_gym;

-- ---------------------------------------------------------
-- codigo específico -registra un socio; si el id ya existe (error 1062) avisa sin romper el programa
-- ---------------------------------------------------------
DELIMITER //
CREATE PROCEDURE sp_registrar_socio_seguro(
    IN p_socio_id INT,
    IN p_nombres VARCHAR(50),
    IN p_apellidos VARCHAR(50),
    IN p_telefono VARCHAR(15),
    OUT p_mensaje VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET p_mensaje = 'Error: el socio ya existe';
    END;

    INSERT INTO socios (socio_id, nombres, apellidos, telefono)
    VALUES 
        (p_socio_id, p_nombres, p_apellidos, p_telefono);

    SET p_mensaje = 'Socio registrado correctamente';
END //
DELIMITER ;

-- ---------------------------------------------------------
-- transacción -asigna un plan a un socio, si algo falla, revierte todo con ROLLBACK
-- ---------------------------------------------------------
DELIMITER //
CREATE PROCEDURE sp_asignar_plan_transaccion(
    IN p_id_asignacion INT,
    IN p_socio_id INT,
    IN p_plan_id VARCHAR(5),
    IN p_entrenador_id VARCHAR(5),
    IN p_sede_id VARCHAR(5),
    IN p_fecha DATE,
    OUT p_mensaje VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_mensaje = 'Error: no se pudo asignar el plan, se revirtió la operación';
    END;

    START TRANSACTION;

    INSERT INTO socio_plan_entrenamiento
        (socio_plan_entrenamiento_id, socio_id, plan_entrenamiento_id, entrenador_id, sede_id, fecha_asignacion, estado)
    VALUES
        (p_id_asignacion, p_socio_id, p_plan_id, p_entrenador_id, p_sede_id, p_fecha, 'Activo');

    COMMIT;
    SET p_mensaje = 'Plan asignado correctamente';
END //
DELIMITER ;
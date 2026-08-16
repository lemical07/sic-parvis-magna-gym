USE sic_parvis_magna_gym;

-- ---------------------------------------------------------
-- WHILE-calcula cuántas cuotas del plan puede pagar un socio con su presupuesto
-- ---------------------------------------------------------
DELIMITER //
CREATE PROCEDURE sp_bucle_while(
    IN p_presupuesto DECIMAL(8,2),
    IN p_precio_plan DECIMAL(8,2),
    OUT p_cuotas_pagables INT
)
BEGIN
    DECLARE v_restante DECIMAL(8,2);
    SET v_restante = p_presupuesto;
    SET p_cuotas_pagables = 0;

    WHILE v_restante >= p_precio_plan DO
        SET v_restante = v_restante - p_precio_plan;
        SET p_cuotas_pagables = p_cuotas_pagables + 1;
    END WHILE;
END //
DELIMITER ;

-- ---------------------------------------------------------
-- REPEAT -busca el siguiente socio_id disponible a partir de uno dado
-- ---------------------------------------------------------
DELIMITER //
CREATE PROCEDURE sp_bucle_repeat(
    IN p_id_inicial INT,
    OUT p_id_disponible INT
)
BEGIN
    DECLARE v_existe INT;
    SET p_id_disponible = p_id_inicial;

    REPEAT
        SELECT COUNT(*) INTO v_existe
        FROM socios
        WHERE socio_id = p_id_disponible;

        IF v_existe > 0 THEN
            SET p_id_disponible = p_id_disponible + 1;
        END IF;
    UNTIL v_existe = 0
    END REPEAT;
END //
DELIMITER ;

-- ---------------------------------------------------------
-- CASE -clasifica a un entrenador según su porcentaje de comisión
-- ---------------------------------------------------------
DELIMITER //
CREATE PROCEDURE sp_clasificar_entrenador(
    IN p_entrenador_id VARCHAR(5),
    OUT p_categoria VARCHAR(20)
)
BEGIN
    DECLARE v_comision DECIMAL(4,2);

    SELECT porcentaje_comision 
        INTO v_comision
        FROM entrenadores
    WHERE entrenador_id = p_entrenador_id;

    CASE
        WHEN v_comision < 0.10 THEN 
            SET p_categoria = 'Comisión baja';
        WHEN v_comision BETWEEN 0.10 AND 0.14 THEN 
            SET p_categoria = 'Comisión media';
        ELSE SET p_categoria = 'Comisión alta';
    END CASE;
END //
DELIMITER ;

-- ---------------------------------------------------------
-- LOOP -suma la comisión acumulada de un entrenador para N asignaciones del mismo plan
-- ---------------------------------------------------------
DELIMITER //
CREATE PROCEDURE sp_bucle_loop(
    IN p_precio_plan DECIMAL(8,2),
    IN p_comision DECIMAL(4,2),
    IN p_cantidad_asignaciones INT,
    OUT p_comision_total DECIMAL(8,2)
)
BEGIN
    DECLARE v_contador INT DEFAULT 0;
    SET p_comision_total = 0;

    mi_loop: LOOP
        IF v_contador >= p_cantidad_asignaciones THEN
            LEAVE mi_loop;
        END IF;

        SET p_comision_total = p_comision_total + (p_precio_plan * p_comision);
        SET v_contador = v_contador + 1;
    END LOOP mi_loop;
END //
DELIMITER ;
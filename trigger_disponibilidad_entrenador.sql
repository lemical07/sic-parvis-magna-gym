-- ------------------------------------------------------------
-- verifica que el entrenador no supere su cupo de socios activos
-- ------------------------------------------------------------
USE sic_parvis_magna_gym;

DELIMITER //
CREATE TRIGGER trg_verificar_disponibilidad_entrenador
BEFORE INSERT ON socio_plan_entrenamiento
FOR EACH ROW
BEGIN
    DECLARE v_asignaciones_activas INT;
    DECLARE v_max_socios INT;

    -- Cuántas asignaciones activas tiene ya ese entrenador
    SELECT COUNT(*) INTO v_asignaciones_activas
        FROM socio_plan_entrenamiento
    WHERE entrenador_id = NEW.entrenador_id AND estado = 'Activo';

    -- Cuál es su cupo máximo permitido
    SELECT max_socios_simultaneos INTO v_max_socios
        FROM entrenadores
    WHERE entrenador_id = NEW.entrenador_id;

    -- Si la nueva asignación es activa y ya está en el tope, se bloquea
    IF NEW.estado = 'Activo' AND v_asignaciones_activas >= v_max_socios THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El entrenador ya alcanzó su cupo máximo de socios activos';
    END IF;
END //
DELIMITER ;
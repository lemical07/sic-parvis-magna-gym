-- -------------------------------------------------------------
-- evento que genera un reporte diario de socios por entrenador
-- -------------------------------------------------------------
USE sic_parvis_magna_gym;
CREATE TABLE IF NOT EXISTS reporte_socios_por_entrenador (
    reporte_id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    entrenador_id VARCHAR(5) NOT NULL,
    total_socios INT NOT NULL
);

-- asegura que el programador de eventos de MySQL esté activo
SET GLOBAL event_scheduler = ON;

DELIMITER //
CREATE EVENT ev_reporte_diario_socios
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 DAY
DO
BEGIN
    INSERT INTO reporte_socios_por_entrenador (fecha, entrenador_id, total_socios)
    SELECT
        CURDATE(),
        entrenador_id,
        COUNT(*)
        FROM socio_plan_entrenamiento
    WHERE fecha_asignacion = CURDATE()
        GROUP BY entrenador_id;
END //
DELIMITER ;
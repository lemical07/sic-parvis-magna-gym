USE gym_database;

-- CIUDADES
INSERT INTO ciudades (ciudad_id, nombre_ciudad) VALUES
('C01', 'Madrid');

-- SEDES
INSERT INTO sedes (sede_id, nombre_sede, ciudad_id) VALUES
('S01', 'Sede Norte', 'C01'),
('S02', 'Sede Sur',   'C01');

-- SOCIOS
INSERT INTO socios (socio_id, nombres, apellidos, telefono) VALUES
(101, 'Ana',  'Pérez', '555-1234'),
(102, 'Luis', 'Gómez', '555-5678'),
(103, 'Carla','Ruíz',  '555-9012');

-- ESPECIALIDADES_ENTRENADORES
INSERT INTO especialidades_entrenadores (especialidad_id, nombre_especialidad) VALUES
('EE01', 'Yoga'),
('EE02', 'Musculación'),
('EE03', 'Funcional'),
('EE04', 'Boxeo');

-- ENTRENADORES
INSERT INTO entrenadores (entrenador_id, nombre_entrenador, especialidad_id, porcentaje_comision, max_socios_simultaneos) VALUES
('E01', 'Carlos', 'EE01', 0.10, 5),
('E02', 'Marta',  'EE02', 0.15, 3),
('E03', 'Iván',   'EE03', 0.12, 4),
('E04', 'Diego',  'EE04', 0.10, 5);

-- PLANES_ENTRENAMIENTO
INSERT INTO planes_entrenamiento (plan_entrenamiento_id, plan_entrenamiento, precio) VALUES
('PE01', 'Yoga',     250.00),
('PE02', 'Pesas',    300.00),
('PE03', 'CrossFit', 350.00),
('PE04', 'Boxeo',    280.00);

-- SOCIO_PLAN_ENTRENAMIENTO
INSERT INTO socio_plan_entrenamiento (socio_plan_entrenamiento_id, socio_id, plan_entrenamiento_id, entrenador_id, sede_id, fecha_asignacion, estado) VALUES
(1001, 101, 'PE01', 'E01', 'S01', '2026-08-01', 'Activo'),
(1002, 101, 'PE02', 'E02', 'S01', '2026-08-03', 'Activo'),
(1003, 102, 'PE03', 'E03', 'S02', '2026-08-05', 'Activo'),
(1004, 103, 'PE02', 'E02', 'S01', '2026-08-10', 'Activo'),
(1005, 103, 'PE04', 'E04', 'S01', '2026-08-12', 'Finalizado');
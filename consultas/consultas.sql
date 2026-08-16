USE sic_parvis_magna_gym;

-- ---------------------------------------------------------
-- INNER JOIN -socio con su plan, entrenador y sede asignados
-- ---------------------------------------------------------
SELECT
    s.nombres,
    s.apellidos,
    p.plan_entrenamiento,
    e.nombre_entrenador,
    se.nombre_sede
FROM socio_plan_entrenamiento spe
    INNER JOIN socios s ON spe.socio_id = s.socio_id
    INNER JOIN planes_entrenamiento p ON spe.plan_entrenamiento_id = p.plan_entrenamiento_id
    INNER JOIN entrenadores e ON spe.entrenador_id = e.entrenador_id
    INNER JOIN sedes se ON spe.sede_id = se.sede_id;

-- ---------------------------------------------------------
-- IN -socios que tienen asignado el plan de Yoga o de Boxeo
-- ---------------------------------------------------------
SELECT
    s.nombres,
    s.apellidos,
    spe.plan_entrenamiento_id
FROM socios s
    INNER JOIN socio_plan_entrenamiento spe ON s.socio_id = spe.socio_id
WHERE spe.plan_entrenamiento_id IN ('PE01', 'PE04');

-- ---------------------------------------------------------
-- INNER JOIN + IN combinados -entrenadores especializados en Yoga o Musculación con su sede
-- ---------------------------------------------------------
SELECT DISTINCT
    e.nombre_entrenador,
    ee.nombre_especialidad,
    se.nombre_sede
FROM entrenadores e
    INNER JOIN especialidades_entrenadores ee ON e.especialidad_id = ee.especialidad_id
    INNER JOIN socio_plan_entrenamiento spe ON e.entrenador_id = spe.entrenador_id
    INNER JOIN sedes se ON spe.sede_id = se.sede_id
WHERE ee.especialidad_id IN ('EE01', 'EE02');

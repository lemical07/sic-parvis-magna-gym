DROP DATABASE IF EXISTS sic_parvis_magna_gym;
CREATE DATABASE IF NOT EXISTS sic_parvis_magna_gym;

USE gym_database;

-- ---------------------------------------------------------
-- CIUDADES
-- ---------------------------------------------------------
CREATE TABLE ciudades (
    ciudad_id VARCHAR(5) PRIMARY KEY,
    nombre_ciudad VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------
-- SEDES
-- ---------------------------------------------------------
CREATE TABLE sedes (
    sede_id VARCHAR(5)  PRIMARY KEY,
    nombre_sede VARCHAR(50) NOT NULL,
    ciudad_id VARCHAR(5)  NOT NULL,

    FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

-- ---------------------------------------------------------
-- SOCIOS
-- ---------------------------------------------------------
CREATE TABLE socios (
    socio_id INT PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    telefono VARCHAR(15)
);

-- ---------------------------------------------------------
-- ESPECIALIDADES_ENTRENADORES
-- ---------------------------------------------------------
CREATE TABLE especialidades_entrenadores (
    especialidad_id VARCHAR(5) PRIMARY KEY,
    nombre_especialidad VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------
-- ENTRENADORES
-- ---------------------------------------------------------
CREATE TABLE entrenadores (
    entrenador_id VARCHAR(5) PRIMARY KEY,
    nombre_entrenador VARCHAR(50) NOT NULL,
    especialidad_id VARCHAR(5) NOT NULL,
    porcentaje_comision DECIMAL(4,2) NOT NULL DEFAULT 0.10,
    max_socios_simultaneos INT  NOT NULL DEFAULT 5,

    FOREIGN KEY (especialidad_id) REFERENCES especialidades_entrenadores(especialidad_id)
);

-- ---------------------------------------------------------
-- PLANES_ENTRENAMIENTO
-- ---------------------------------------------------------
CREATE TABLE planes_entrenamiento (
    plan_entrenamiento_id VARCHAR(5) PRIMARY KEY,
    plan_entrenamiento VARCHAR(50) NOT NULL,
    precio DECIMAL(8,2) NOT NULL
);

-- ---------------------------------------------------------
-- SOCIO_PLAN_ENTRENAMIENTO (tabla puente)
-- ---------------------------------------------------------
CREATE TABLE socio_plan_entrenamiento (
    socio_plan_entrenamiento_id INT PRIMARY KEY,
    socio_id INT NOT NULL,
    plan_entrenamiento_id VARCHAR(5) NOT NULL,
    entrenador_id VARCHAR(5) NOT NULL,
    sede_id VARCHAR(5) NOT NULL,
    fecha_asignacion DATE NOT NULL, 
    estado ENUM('Activo','Finalizado') NOT NULL DEFAULT 'Activo', 

    FOREIGN KEY (socio_id) REFERENCES socios(socio_id),
    FOREIGN KEY (plan_entrenamiento_id) REFERENCES planes_entrenamiento(plan_entrenamiento_id),
    FOREIGN KEY (entrenador_id) REFERENCES entrenadores(entrenador_id),
    FOREIGN KEY (sede_id) REFERENCES sedes(sede_id)
);
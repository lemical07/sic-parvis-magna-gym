# Sic Parvis Magna Gym

Base de datos relacional para la gestión de un gimnasio: socios, sedes, planes de entrenamiento, entrenadores y la asignación entre ellos. El modelo fue normalizado paso a paso desde 1FN hasta 4FN/BCNF (ver `docs/diagrama_4fn_bcnf.png`).

## Descripción del modelo

El punto de partida es una sola tabla con datos repetidos y dependencias mezcladas (socio, plan, entrenador, especialidad y sede en una fila). A través del proceso de normalización se separó en las siguientes entidades:

| Tabla | Descripción |
|---|---|
| `socios` | Datos personales del socio (nombres, apellidos, teléfono) |
| `sedes` | Sedes del gimnasio, cada una asociada a una ciudad |
| `ciudades` | Catálogo de ciudades |
| `planes_entrenamiento` | Catálogo de planes (Yoga, Pesas, CrossFit, Boxeo) con su precio |
| `entrenadores` | Datos del entrenador, su especialidad, porcentaje de comisión y cupo máximo de socios simultáneos |
| `especialidades_entrenadores` | Catálogo de especialidades (Yoga, Musculación, Funcional, Boxeo) |
| `socio_plan_entrenamiento` | Tabla puente: qué socio tiene qué plan, con qué entrenador, en qué sede, desde qué fecha y en qué estado |

Campos que no venían en el diagrama original y se agregaron para poder implementar la lógica de negocio (comisiones, disponibilidad, reportes), ya aprobados:

- `planes_entrenamiento.precio`
- `entrenadores.porcentaje_comision`
- `entrenadores.max_socios_simultaneos`
- `socio_plan_entrenamiento.fecha_asignacion`
- `socio_plan_entrenamiento.estado` (`Activo` / `Finalizado`)

## Estructura del proyecto

```
sic-parvis-magna-gym/
├── docs/
│   └── diagrama_4fn_bcnf.png          # Proceso de normalización 1FN → 4FN/BCNF
├── ddl/
│   └── ddl.sql                        # Creación de la base de datos y las tablas
├── dml/
│   └── dml.sql                        # Datos de prueba
├── consultas/
│   └── consultas.sql                  # Consultas DQL (INNER JOIN, IN)
├── funciones/
│   ├── funciones_simples.sql
│   ├── funciones_condicionales.sql
│   ├── funciones_bucles.sql
│   ├── funciones_datos_bd.sql
│   ├── funciones_no_deterministicas.sql
│   └── funciones_manejo_errores.sql
├── procedures/
│   ├── bucles.sql                     # WHILE, REPEAT, CASE, LOOP
│   ├── manejo_errores.sql             # Código de error específico y transacción con ROLLBACK
│   └── parametros_in_out_inout.sql    # Parámetros IN, OUT, INOUT
├── trigger-events/
│   ├── trigger_disponibilidad_entrenador.sql
│   └── evento_reporte_diario.sql
├── usuario/
│   └── usuarios.sql                   # Creación de usuarios y permisos
├── PRUEBAS.md                         # Casos de prueba de todos los objetos anteriores
└── README.md
```

## Orden de ejecución

El orden importa porque cada script depende de los objetos creados por el anterior:

1. `ddl/ddl.sql` — crea la base de datos y las tablas
2. `dml/dml.sql` — carga los datos de prueba
3. `funciones/*.sql` — cualquier orden entre ellos
4. `procedures/*.sql` — cualquier orden entre ellos
5. `trigger-events/*.sql` — el evento crea su propia tabla de reportes
6. `usuario/usuarios.sql` — usuarios y permisos
7. `consultas/consultas.sql` — para validar que todo lo anterior quedó bien

## Requisitos

- MySQL 8.x
- VS Code con extensión de MySQL (o cualquier cliente equivalente)
- `event_scheduler` activo si se quiere probar el evento en su horario real (ver `PRUEBAS.md`, sección 6)

## Pruebas

Todos los casos de prueba de funciones, procedimientos, trigger, evento y consultas están en [`PRUEBAS.md`](./PRUEBAS.md), con el SQL a ejecutar y el resultado esperado de cada uno.

## Convenciones del proyecto

- Nombres de tablas, columnas y objetos en español, en minúsculas y con guión bajo
- Todo el código y los comentarios en español
- Cada procedimiento/función/trigger documentado con un comentario breve sobre su propósito justo antes de la definición
# Pruebas — sic-parvis-magna-gym

Checklist de pruebas de los objetos de BD. No se repite el código (ya está en sus respectivos `.sql`), solo qué probar y qué debe pasar.

**Antes de probar:** tener cargados `ddl.sql`, `dml.sql` y los objetos correspondientes.

## Funciones

| Función | Qué probar |
|---|---|
| `fn_comision_acumulada` | Resultado = precio × porcentaje × veces |
| `fn_categoria_plan` | Clasifica correctamente según el rango de precio del plan |
| `fn_nombre_completo_socio` | Devuelve "Nombres Apellidos" del socio |
| `fn_dividir_seguro` | Con denominador 0 devuelve NULL, no error |
| `fn_marca_tiempo_reporte` | Dos llamadas seguidas devuelven horas distintas |
| `fn_calcular_precio_con_iva` | Resultado = monto × 1.12 |
| `fn_calcular_comision_entrenador` | Resultado = precio del plan × comisión del entrenador |

## Procedimientos — bucles

| Procedimiento | Qué probar |
|---|---|
| `sp_bucle_while` | Cuenta solo cuotas completas que caben en el presupuesto |
| `sp_bucle_repeat` | Devuelve el primer `socio_id` libre a partir del dado |
| `sp_clasificar_entrenador` | Categoría correcta según su comisión |
| `sp_bucle_loop` | Comisión total = precio × comisión × cantidad |

## Procedimientos — manejo de errores

| Procedimiento | Qué probar |
|---|---|
| `sp_registrar_socio_seguro` | Socio nuevo se registra bien; socio repetido atrapa el error 1062 sin caerse |
| `sp_asignar_plan_transaccion` | Asignación válida se guarda; asignación con PK repetida hace ROLLBACK y no deja fila duplicada |

## Procedimientos — parámetros IN / OUT / INOUT

| Procedimiento | Qué probar |
|---|---|
| `sp_contar_planes_activos_socio` | Cuenta correctamente los planes con `estado = 'Activo'` |
| `sp_aplicar_descuento` | El precio se modifica directamente vía INOUT |
| `sp_registrar_socio` | Inserta la fila con los datos correctos |
| `sp_clasificar_plan` | Categoría correcta según el precio del plan |

## Trigger — `trg_verificar_disponibilidad_entrenador`

- Insertar asignaciones activas hasta llenar `max_socios_simultaneos` del entrenador → deben pasar
- Una asignación activa más allá del cupo → debe bloquear con error 45000
- Una asignación con `estado = 'Finalizado'` aunque el cupo esté lleno → debe pasar sin error

## Evento — `ev_reporte_diario_socios`

- `event_scheduler` debe estar en `ON`
- Al ejecutar la lógica del evento, debe generar una fila por entrenador con asignaciones del día, con el conteo correcto

## Consultas (`consultas.sql`)

| Consulta | Qué probar |
|---|---|
| INNER JOIN (socio + plan + entrenador + sede) | Ninguna columna sale en NULL |
| IN (planes PE01 o PE04) | Solo devuelve filas con esos dos planes |
| INNER JOIN + IN (entrenadores por especialidad) | Sin filas duplicadas, solo especialidades EE01 o EE02 |
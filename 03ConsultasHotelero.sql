-- a. Los datos de las habitaciones, junto con todas las reservas realizadas de esa habitación,
-- fecha en que se realizó, estado y el monto cobrado.
SELECT
  h.idHabitacion,
  h.numero,
  h.superficie,
  h.terraza,
  h.limpia,
  h.libre,
  th.nombre AS tipohabitacion,
  r.idReserva,
  r.fechaEntrada AS fecharealizacion,
  r.estado,
  f.totalFacturado AS montocobrado
FROM Habitacion AS h
JOIN TipoHabitacion AS th
  ON th.idTipoHabitacion = h.idTipoHabitacion
LEFT JOIN Reserva AS r
  ON r.idHabitacion = h.idHabitacion
LEFT JOIN Factura AS f
  ON f.idReserva = r.idReserva
ORDER BY h.numero, r.fechaReserva;
-- b. El monto total facturado por el Hotel discriminado por año y forma de pago.
SELECT
  YEAR(fechaFactura) AS anio,
  formaPago,
  SUM(totalFacturado) AS montototal
FROM Factura
GROUP BY YEAR(fechaFactura), formaPago
ORDER BY anio, formaPago;
-- c. Listado de precios para el año en curso.
SELECT
  th.nombre AS tipohabitacion,
  v.precio AS precio,
  YEAR(v.fechaDesde) AS anio
FROM Valorizacion AS v
JOIN TipoHabitacion AS th
  ON th.idTipoHabitacion = v.idTipoHabitacion
WHERE YEAR(v.fechaDesde) = YEAR(CURDATE())
ORDER BY th.nombre, v.fechaDesde;
-- d. Dado un cliente devolver todas las reservas y los servicios consumidos en cada una
-- ordenados por fecha de reserva de forma descendiente.
SELECT
  c.idCliente,
  CONCAT(c.apellido, ', ', c.nombre) AS cliente,
  r.idReserva,
  r.fechaReserva,
  r.estado,
  s.descripcion AS servicio,
  sr.fecha AS fechaservicio,
  sr.cantidad,
  sr.importe
FROM Cliente AS c
JOIN Reserva AS r
  ON r.idCliente = c.idCliente
LEFT JOIN ServicioReserva AS sr
  ON sr.idReserva = r.idReserva
LEFT JOIN Servicio AS s
  ON s.idServicio = sr.idServicio
WHERE c.idCliente = 1 -- o c.dni para buscar por DNI
ORDER BY r.fechaReserva DESC, sr.fecha;

-- e. Dada una habitación devolver todas las reservas realizadas que fueron canceladas.
SELECT
  h.idHabitacion,
  h.numero AS numerohabitacion,
  r.idReserva,
  r.fechaReserva,
  r.estado,
  r.fechaEntrada,
  r.noches,
  CONCAT(c.apellido, ', ', c.nombre) AS cliente
FROM Habitacion AS h
JOIN Reserva AS r
  ON r.idHabitacion = h.idHabitacion
JOIN Cliente AS c
  ON c.idCliente = r.idCliente
WHERE h.idHabitacion = 2
  AND r.estado = 'cancelada'
ORDER BY r.fechaReserva DESC;

-- f. Un listado de las reservas pendientes que estén en condición de pasar al estado “cancelada”
SELECT
  r.idReserva,
  CONCAT(c.apellido, ', ', c.nombre) AS cliente,
  h.numero AS numerohabitacion,
  r.fechaReserva,
  r.fechaEntrada,
  r.estado
FROM Reserva AS r
JOIN Cliente AS c ON c.idCliente = r.idCliente
JOIN Habitacion AS h ON h.idHabitacion = r.idHabitacion
WHERE r.estado = 'pendiente'
  AND CURDATE() > DATE_SUB(r.fechaEntrada, INTERVAL 4 DAY)
ORDER BY r.fechaEntrada;

-- g. Un listado de las habitaciones que tienen pagos parciales o señas (sin facturar)
-- ordenadas por fecha de entrada.
SELECT DISTINCT
  h.idHabitacion,
  h.numero AS numero_habitacion,
  r.idReserva,
  r.fechaEntrada,
  r.estado
FROM Reserva AS r
JOIN Habitacion AS h
  ON h.idHabitacion = r.idHabitacion
JOIN Pago AS p
  ON p.idReserva = r.idReserva
LEFT JOIN Factura AS f
  ON f.idReserva = r.idReserva
WHERE p.tipo IN ('Seña','Parcial')
  AND f.idReserva IS NULL
ORDER BY r.fechaEntrada;
-- h. Los clientes que hayan gastado mas de 1.000.000 en servicio de restaurante en algún
-- año.
SELECT
  c.idCliente,
  CONCAT(c.apellido,', ', c.nombre) AS cliente,
  YEAR(sr.fecha),
  SUM(sr.importe) AS totalrestaurante
FROM Cliente AS c
JOIN Reserva AS r
  ON r.idCliente = c.idCliente
JOIN ServicioReserva AS sr
  ON sr.idReserva = r.idReserva
JOIN Servicio AS s
  ON s.idServicio = sr.idServicio
WHERE s.descripcion = 'Restaurante'
GROUP BY c.idCliente, anio
HAVING SUM(sr.importe) > 1000000
ORDER BY anio, total_restaurante DESC;

-- i. Dado un servicio listar todas sus realizaciones detallando que cliente lo realizo.
SELECT
  s.idServicio,
  s.codigoUnico,
  s.descripcion,
  sr.idServicioReserva,
  sr.fecha AS fecha_realizacion,
  sr.cantidad,
  sr.importe,
  r.idReserva,
  CONCAT(c.apellido, ', ', c.nombre) AS cliente
FROM Servicio AS s
JOIN ServicioReserva AS sr
  ON sr.idServicio = s.idServicio
JOIN Reserva AS r
  ON r.idReserva = sr.idReserva
JOIN Cliente AS c
  ON c.idCliente = r.idCliente
WHERE s.idServicio = 1 -- cambiar 
ORDER BY sr.fecha;
-- j. Realizar un reporte completo de una reserva.
/*El unir todas las tablas en una sola consulta 
(Reserva, Pago y ServicioReserva) generaría un producto cartesiano .
Por lo que esta consulta resuelve los totales de la reserva*/
SELECT
  r.idReserva,
  r.fechaReserva,
  r.estado,
  r.fechaEntrada,
  r.noches,
  CONCAT(c.apellido, ', ', c.nombre) AS cliente,
  c.DNI,
  h.numero AS habitacion,
  th.nombre AS tipoHabitacion,
-- totales 
-- total de habitacion
  r.noches * (
    SELECT v.precio
    FROM Valorizacion v
    WHERE v.idTipoHabitacion = th.idTipoHabitacion
      AND v.fechaDesde <= r.fechaEntrada
    ORDER BY v.fechaDesde DESC
    LIMIT 1
  ) AS totalhabitacion,
  -- total de servicios
  COALESCE((
    SELECT SUM(sr.importe)
    FROM ServicioReserva sr
    WHERE sr.idReserva = r.idReserva ),0) AS totalservicios,
  -- pagos totales 
  COALESCE((
    SELECT SUM(p.monto)
    FROM Pago p
    WHERE p.idReserva = r.idReserva
  ),0) AS totalpagos,
  -- total de estadia (servicios mas habitacion)
  (r.noches * (
      SELECT v.precio
      FROM Valorizacion v
      WHERE v.idTipoHabitacion = th.idTipoHabitacion
        AND v.fechaDesde <= r.fechaEntrada
      ORDER BY v.fechaDesde DESC
      LIMIT 1
    )
    + COALESCE((
        SELECT SUM(sr.importe)
        FROM ServicioReserva sr
        WHERE sr.idReserva = r.idReserva
      ),0)
  ) AS subtotalestadia,
  -- total de la factura
  f.totalFacturado AS totalfacturado
FROM Reserva r
JOIN Cliente c ON c.idCliente = r.idCliente
JOIN Habitacion h ON h.idHabitacion = r.idHabitacion
JOIN TipoHabitacion th ON th.idTipoHabitacion = h.idTipoHabitacion
LEFT JOIN Factura f ON f.idReserva = r.idReserva
WHERE r.idReserva = 1; -- cambiar

-- k. Dada una fecha de inicio y una fecha de fin obtener todas las habitaciones que estén
-- disponibles para todo el rango de fechas.
SELECT
  h.idHabitacion,
  h.numero AS numerohabitacion,
  th.nombre AS tipohabitacion,
  h.superficie,
  h.terraza,
  h.limpia
FROM Habitacion AS h
JOIN TipoHabitacion AS th
  ON th.idTipoHabitacion = h.idTipoHabitacion
WHERE NOT EXISTS (
  SELECT 1
  FROM Reserva AS r
  WHERE r.idHabitacion = h.idHabitacion
    AND r.estado <> 'cancelada'
    AND (
      r.fechaEntrada < '2025-10-25' AND
      (r.fechaEntrada + INTERVAL r.noches DAY) > '2025-10-20'
    )
)
ORDER BY h.numero;
-- l. Establecer los precios de las habitaciones para el año 2026, teniendo en cuenta que el
-- monto aumenta en un 15% respecto de año anterior para todos los tipos de habitación,
-- excepto para la del tipo “Doble Superior” que aumenta en un 20 %.
INSERT INTO Valorizacion (fechaDesde, idTipoHabitacion, precio)
SELECT
  DATE('2026-01-01') AS fechaDesde,
  th.idTipoHabitacion,
  (
      SELECT v.precio
      FROM Valorizacion v
      WHERE v.idTipoHabitacion = th.idTipoHabitacion AND YEAR(v.fechaDesde) = 2025
      ORDER BY v.fechaDesde DESC
      LIMIT 1
    ) * (CASE WHEN th.nombre = 'Doble Superior' THEN 1.20 ELSE 1.15 END) AS precio
FROM TipoHabitacion th;
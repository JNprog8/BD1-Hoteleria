-- a. Los datos de las habitaciones, junto con todas las reservas realizadas de esa habitación,
-- fecha en que se realizó, estado y el monto cobrado.
SELECT
  h.numero,
  h.superficie,
  h.terraza,
  h.limpia,
  h.libre,
  h.nombreTipoHabitacion AS tipohabitacion,
  r.idReserva,
  r.fechaEntrada AS fecharealizacion,
  r.estado,
  f.totalFacturado AS montocobrado
FROM Habitacion AS h
LEFT JOIN Reserva AS r
  ON r.numeroHabitacion = h.numero
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
  v.nombreTipoHabitacion AS tipohabitacion,
  v.precio AS precio,
  YEAR(v.fechaDesde) AS anio
FROM Valorizacion AS v
WHERE YEAR(v.fechaDesde) = YEAR(CURDATE())
ORDER BY v.nombreTipoHabitacion, v.fechaDesde;

-- d. Dado un cliente devolver todas las reservas y los servicios consumidos en cada una
-- ordenados por fecha de reserva de forma descendiente.
SELECT
  c.DNI,
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
  ON r.dniCliente = c.DNI
LEFT JOIN ServicioReserva AS sr
  ON sr.idReserva = r.idReserva
LEFT JOIN Servicio AS s
  ON s.codigo = sr.codigoServicio
WHERE c.DNI = '28956789' -- DNI disponibles de clientes: '28956789','31234567','24567890','40765432','37654321'
ORDER BY r.fechaReserva DESC, sr.fecha;

-- e. Dada una habitación devolver todas las reservas realizadas que fueron canceladas.
SELECT
  h.numero AS numerohabitacion,
  r.idReserva,
  r.fechaReserva,
  r.estado,
  r.fechaEntrada,
  r.noches,
  CONCAT(c.apellido, ', ', c.nombre) AS cliente
FROM Habitacion AS h
JOIN Reserva AS r
  ON r.numeroHabitacion = h.numero
JOIN Cliente AS c
  ON c.DNI = r.dniCliente
WHERE h.numero = '102' -- numeros de habitacion disponibles: '101','102','201','202','301','302'
  AND r.estado = 'cancelada'
ORDER BY r.fechaReserva DESC;

-- f. Un listado de las reservas pendientes que estén en condición de pasar al estado "cancelada"
SELECT
  r.idReserva,
  CONCAT(c.apellido, ', ', c.nombre) AS cliente,
  h.numero AS numerohabitacion,
  r.fechaReserva,
  r.fechaEntrada,
  r.estado
FROM Reserva AS r
JOIN Cliente AS c 
  ON c.DNI = r.dniCliente
JOIN Habitacion AS h 
  ON h.numero = r.numeroHabitacion
WHERE r.estado = 'pendiente'
  AND CURDATE() > DATE_SUB(r.fechaEntrada, INTERVAL 4 DAY)
ORDER BY r.fechaEntrada;

-- g. Un listado de las habitaciones que tienen pagos parciales o señas (sin facturar)
-- ordenadas por fecha de entrada.
SELECT DISTINCT
  h.numero AS numero_habitacion,
  r.idReserva,
  r.fechaEntrada,
  r.estado
FROM Reserva AS r
JOIN Habitacion AS h
  ON h.numero = r.numeroHabitacion
JOIN Pago AS p
  ON p.idReserva = r.idReserva
LEFT JOIN Factura AS f
  ON f.idReserva = r.idReserva
WHERE p.tipo IN ('Seña','Parcial')
  AND f.idReserva IS NULL
ORDER BY r.fechaEntrada;

-- h. Los clientes que hayan gastado mas de 1.000.000 en servicio de restaurante en algún año.
SELECT
  c.DNI,
  CONCAT(c.apellido, ', ', c.nombre) AS cliente,
  YEAR(sr.fecha) AS anio,
  SUM(sr.importe) AS totalrestaurante
FROM Cliente AS c
JOIN Reserva AS r
  ON r.dniCliente = c.DNI
JOIN ServicioReserva AS sr
  ON sr.idReserva = r.idReserva
JOIN Servicio AS s
  ON s.codigo = sr.codigoServicio
WHERE s.descripcion = 'Restaurante'
GROUP BY c.DNI, c.apellido, c.nombre, anio
HAVING SUM(sr.importe) > 1000000
ORDER BY anio, totalrestaurante DESC;

-- i. Dado un servicio listar todas sus realizaciones detallando que cliente lo realizo.
SELECT
  s.codigo,
  s.descripcion,
  sr.idServicioReserva,
  sr.fecha AS fecha_realizacion,
  sr.cantidad,
  sr.importe,
  r.idReserva,
  CONCAT(c.apellido, ', ', c.nombre) AS cliente
FROM Servicio AS s
JOIN ServicioReserva AS sr
  ON sr.codigoServicio = s.codigo
JOIN Reserva AS r
  ON r.idReserva = sr.idReserva
JOIN Cliente AS c
  ON c.DNI = r.dniCliente
WHERE s.codigo = 'RES' -- Codigos de Servicios Disponibles: 'RES','BAR','SPA','LAV','TRI','MIN','EST','FLO'
ORDER BY sr.fecha;

-- j. Realizar un reporte completo de una reserva.
-- El unir todas las tablas en una sola consulta (Reserva, Pago y ServicioReserva) 
-- generaría un producto cartesiano. Por lo que esta consulta resuelve los totales de la reserva
SELECT
  r.idReserva,
  r.fechaReserva,
  r.estado,
  r.fechaEntrada,
  r.noches,
  CONCAT(c.apellido, ', ', c.nombre) AS cliente,
  c.DNI,
  h.numero AS habitacion,
  h.nombreTipoHabitacion AS tipoHabitacion,
  r.noches * (
    SELECT v.precio
    FROM Valorizacion v
    WHERE v.nombreTipoHabitacion = h.nombreTipoHabitacion
      AND v.fechaDesde <= r.fechaEntrada
    ORDER BY v.fechaDesde DESC
    LIMIT 1
  ) AS totalhabitacion, -- Total de habitación
  COALESCE((
    SELECT SUM(sr.importe)
    FROM ServicioReserva sr
    WHERE sr.idReserva = r.idReserva
  ), 0) AS totalservicios, -- Total de servicios
  COALESCE((
    SELECT SUM(p.monto)
    FROM Pago p
    WHERE p.idReserva = r.idReserva
  ), 0) AS totalpagos, -- Los pagos totales
  (r.noches * (
      SELECT v.precio
      FROM Valorizacion v
      WHERE v.nombreTipoHabitacion = h.nombreTipoHabitacion
        AND v.fechaDesde <= r.fechaEntrada
      ORDER BY v.fechaDesde DESC
      LIMIT 1
    ) 
    + COALESCE((
        SELECT SUM(sr.importe)
        FROM ServicioReserva sr
        WHERE sr.idReserva = r.idReserva
      ), 0)
  ) AS subtotalestadia, -- Total de estadía
  f.totalFacturado AS totalfacturado -- Total de la factura
FROM Reserva r
JOIN Cliente c 
  ON c.DNI = r.dniCliente
JOIN Habitacion h 
  ON h.numero = r.numeroHabitacion
LEFT JOIN Factura f 
  ON f.idReserva = r.idReserva
WHERE r.idReserva = 1; -- Los IDs disponibles: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13

-- k. Dada una fecha de inicio y una fecha de fin obtener todas las habitaciones que estén
-- disponibles para todo el rango de fechas.
SELECT
  h.numero AS numerohabitacion,
  h.nombreTipoHabitacion AS tipohabitacion,
  h.superficie,
  h.terraza,
  h.limpia
FROM Habitacion AS h
WHERE NOT EXISTS (
  SELECT 1
  FROM Reserva AS r
  WHERE r.numeroHabitacion = h.numero
    AND r.estado <> 'cancelada'
    AND (
      r.fechaEntrada < '2025-10-25' -- Fecha fin
      AND (r.fechaEntrada + INTERVAL r.noches DAY) > '2025-10-20' -- Fecha inicio
    )
)
ORDER BY h.numero;

-- l. Establecer los precios de las habitaciones para el año 2026, teniendo en cuenta que el
-- monto aumenta en un 15% respecto del año anterior para todos los tipos de habitación,
-- excepto para la del tipo "Doble Superior" que aumenta en un 20%.
INSERT INTO Valorizacion (fechaDesde, nombreTipoHabitacion, precio)
SELECT
  DATE('2026-01-01') AS fechaDesde,
  th.nombre AS nombreTipoHabitacion,
  (
    SELECT v.precio
    FROM Valorizacion v
    WHERE v.nombreTipoHabitacion = th.nombre 
      AND YEAR(v.fechaDesde) = 2025
    ORDER BY v.fechaDesde DESC
    LIMIT 1
  ) * (CASE WHEN th.nombre = 'Doble Superior' THEN 1.20 ELSE 1.15 END) AS precio
FROM TipoHabitacion th;

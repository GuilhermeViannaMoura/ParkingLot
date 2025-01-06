-- 1. Selecionar todos os usuários com seus endereços, incluindo usuários sem endereço
SELECT l.*, a.*
FROM "Login" l
LEFT JOIN "Address" a ON l.id = a.id;

-- 2. Contar o número de redefinições de senha por usuário e mostrar apenas usuários com mais de uma redefinição
SELECT l.email, COUNT(r.id) reset_count
FROM "Login" l
JOIN "ResetPassword" r ON l.id = r.login_id
GROUP BY l.email
HAVING COUNT(r.id) > 1;

-- 3. Selecionar todos os usuários que têm um endereço em São Paulo e que não estão desativados
SELECT l.*, a.*
FROM "Login" l
JOIN "Address" a ON l.id = a.id
WHERE a.city = 'São Paulo' AND l.deactivated = false;

-- 4. Contar o número de usuários por cidade
SELECT a.city, COUNT(l.id) as user_count
FROM "Login" l
JOIN "Address" a ON l.id = a.id
GROUP BY a.city;

-- 5. Selecionar todos os endereços que foram atualizados nos últimos 7 dias e os usuários correspondentes
SELECT a.*, l.*
FROM "Address" a
JOIN "Login" l ON a.id = l.id
WHERE a."updatedAt" >= current_date - INTERVAL '7 days';

-- 6. Selecionar todos os endereços dos estacionamentos
SELECT a.*
FROM "Address" a
JOIN "Login" l ON a.id = l.id
WHERE l.role = 'PARKING_LOT';

-- 7. Obter todos os horários de um estacionamento
SELECT 
    pl.id AS parking_lot_id,
    pl.name AS parking_lot_name,
    rto.timestamp AS reservation_timestamp,
    tobj.user_text AS user_text,
    tobj.manager_text AS manager_text
FROM 
    "ParkingLot" pl
JOIN 
    "ReservationTimelineObjects" rto ON pl.id = rto.reservation_id
JOIN 
    "TimelineObject" tobj ON rto.status_code = tobj.id
WHERE 
    pl.id = 'id_do_estacionamento';

-- 8. Obter todas as reservas de um estacionamento que estão aguardando serem confirmadas
SELECT *
FROM 
  "Reservation" r
WHERE 
    r.status = 'WAITING' AND r.parking_lot_id = 'id_do_estacionamento';

-- 9. Obter todas as conveniências de um determinado estacionamento
SELECT 
    c.id AS convenience_id,
    c.name AS convenience_name,
    cpl."createdAt" AS added_at,
    cpl."updatedAt" AS updated_at
FROM 
    "Conveniences" c
JOIN 
    "ConveniencesOnParkingLots" cpl ON c.id = cpl.conveniences_id
WHERE 
    cpl.parking_lot_id = 'id_do_estacionamento';

-- 10. Obter todas as reservas feitas por um motorista
SELECT 
    r.id AS reservation_id,
    r.conductor_phone,
    r.conductor_name,
    r.vehicle_id,
    v.plate,
    v.model,
    v.color,
    u.id AS user_id,
    u.name AS user_name,
    u.cpf AS user_cpf,
    r.parking_lot_id,
    r.start_time,
    r.status,
    r.end_time,
    r.duration,
    r.checkin_code,
    r.checkout_code,
    r.internal_reference,
    r."createdAt",
    r."updatedAt",
    r.parking_spot_id,
    r.parking_spot_used
FROM 
    "Reservation" r
JOIN 
    "Vehicle" v ON r.vehicle_id = v.id
JOIN 
    "User" u ON v.user_id = u.id
WHERE 
    u.id = 'user_id';

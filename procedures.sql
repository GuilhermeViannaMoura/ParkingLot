/*
Procedure para Registrar Check-in de Reserva

Descrição: Registra o check-in de uma reserva, atualizando o status da reserva para "DONE", ocupando a vaga correspondente no estacionamento e marcando o horário de início da utilização.
*/
CREATE OR REPLACE PROCEDURE register_checkin(
    reservation_id VARCHAR(255),
    checkin_time TIMESTAMP
)
AS $$
BEGIN
    -- Atualizar o status da reserva e o horário de início
    UPDATE "Reservation"
    SET "status" = 'DONE',
        "start_time" = checkin_time
    WHERE "id" = reservation_id;

    -- Incrementar o número de vagas usadas
    UPDATE "ParkingSpot"
    SET "used_spots" = "used_spots" + 1
    WHERE "id" = (
        SELECT "parking_spot_id" FROM "Reservation" WHERE "id" = reservation_id
    );
END;
$$ LANGUAGE plpgsql;

/*
Procedure para Consultar Disponibilidade de Vagas
Descrição: Retorna o número de vagas disponíveis para um estacionamento específico em tempo real.
*/
CREATE OR REPLACE PROCEDURE check_parking_availability(
    parking_lot_id VARCHAR(255),
    OUT available_spots INTEGER
)
AS $$
BEGIN
    SELECT SUM("total_spots" - "used_spots")
    INTO available_spots
    FROM "ParkingSpot"
    WHERE "parking_lot_id" = parking_lot_id;
END;
$$ LANGUAGE plpgsql;

/*
Procedure para Resetar Senha de Usuário
Descrição: Gera um novo token de redefinição de senha para um usuário, retornando o novo token.
*/
CREATE OR REPLACE PROCEDURE reset_user_password(
    login_email VARCHAR(255),
    OUT reset_token VARCHAR(255)
)
AS $$
DECLARE
    login_id VARCHAR(255);
BEGIN
    -- Obter o login_id com base no email
    SELECT "id" INTO login_id
    FROM "Login"
    WHERE "email" = login_email;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Login com o email % não encontrado', login_email;
    END IF;

    -- Gerar um novo token (usando função random para simplificar)
    reset_token := md5(random()::text || clock_timestamp()::text);

    -- Inserir novo token
    INSERT INTO "ResetPassword" ("id", "login_id", "reset_password_token", "createdAt")
    VALUES (uuid_generate_v4(), login_id, reset_token, CURRENT_TIMESTAMP);
END;
$$ LANGUAGE plpgsql;


/*
Procedure para Cancelar Reserva
Descrição: Permite cancelar uma reserva, liberando a vaga correspondente e atualizando o status da reserva para "CANCELLED".
*/
CREATE OR REPLACE PROCEDURE cancel_reservation(
    reservation_id VARCHAR(255)
)
AS $$
BEGIN
    -- Atualizar o status da reserva
    UPDATE "Reservation"
    SET "status" = 'CANCELLED'
    WHERE "id" = reservation_id;

    -- Liberar a vaga do estacionamento
    UPDATE "ParkingSpot"
    SET "used_spots" = "used_spots" - 1
    WHERE "id" = (
        SELECT "parking_spot_id" FROM "Reservation" WHERE "id" = reservation_id
    );
END;
$$ LANGUAGE plpgsql;

/*
Procedure para Relatório de Uso de Estacionamento
Descrição: Gera um relatório resumido do uso de um estacionamento, incluindo o número de vagas totais, vagas ocupadas, e reservas pendentes.
*/
CREATE OR REPLACE PROCEDURE parking_usage_report(
    parking_lot_id VARCHAR(255),
    OUT total_spots INTEGER,
    OUT used_spots INTEGER,
    OUT pending_reservations INTEGER
)
AS $$
BEGIN
    -- Calcular o total de vagas e vagas ocupadas
    SELECT SUM("total_spots"), SUM("used_spots")
    INTO total_spots, used_spots
    FROM "ParkingSpot"
    WHERE "parking_lot_id" = parking_lot_id;

    -- Calcular reservas pendentes
    SELECT COUNT(*)
    INTO pending_reservations
    FROM "Reservation"
    WHERE "parking_spot_id" IN (
        SELECT "id" FROM "ParkingSpot" WHERE "parking_lot_id" = parking_lot_id
    ) AND "status" = 'PENDING';
END;
$$ LANGUAGE plpgsql;


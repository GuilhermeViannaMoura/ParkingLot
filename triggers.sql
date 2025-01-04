/*
 
 Trigger para Atualizar Disponibilidade do Estacionamento
 
 Sempre que uma nova Reserva for criada ou excluída, o número de vagas usadas no estacionamento (used_spots) deve 
 ser atualizado na tabela ParkingSpot.
 
*/

-- Trigger para criação de reservas
CREATE OR REPLACE FUNCTION update_used_spots_on_insert()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE "ParkingSpot"
    SET "used_spots" = "used_spots" + 1
    WHERE "id" = NEW."parking_spot_id";
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_used_spots_on_insert
AFTER INSERT ON "Reservation"
FOR EACH ROW
EXECUTE FUNCTION update_used_spots_on_insert();

-- Trigger para exclusão de reservas
CREATE OR REPLACE FUNCTION update_used_spots_on_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE "ParkingSpot"
    SET "used_spots" = "used_spots" - 1
    WHERE "id" = OLD."parking_spot_id";
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_used_spots_on_delete
AFTER DELETE ON "Reservation"
FOR EACH ROW
EXECUTE FUNCTION update_used_spots_on_delete();


-- CreateTable
CREATE TABLE "ResetPassword" (
    "id" VARCHAR(255) NOT NULL,
    "login_id" VARCHAR(255) NOT NULL,
    "reset_password_token" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ResetPassword_login_id_key" UNIQUE ("login_id"),
    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Login" (
    "id" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "refresh_token" VARCHAR(255) NOT NULL DEFAULT '',
    "role" TEXT NOT NULL CHECK ("role" IN ('ADMIN', 'USER', 'PARKING_LOT')),
    "deactivated" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Login_email_key" UNIQUE ("email"),
    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Address" (
    "id" VARCHAR(255) NOT NULL,
    "city" VARCHAR(255),
    "state" VARCHAR(255),
    "neighborhood" VARCHAR(255),
    "street" VARCHAR(255),
    "cep" VARCHAR(255),
    "number" INTEGER,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" VARCHAR(255) NOT NULL,
    "cpf" VARCHAR(255),
    "name" VARCHAR(255),
    "login_id" VARCHAR(255),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_cpf_key" UNIQUE ("cpf"),
    CONSTRAINT "User_login_id_key" UNIQUE ("login_id"),
    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ParkingLot" (
    "id" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255),
    "images" JSON,
    "login_id" VARCHAR(255),
    "address_id" VARCHAR(255),
    "company_id" VARCHAR(255),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ParkingLot_login_id_key" UNIQUE ("login_id"),
    CONSTRAINT "ParkingLot_address_id_key" UNIQUE ("address_id"),
    CONSTRAINT "ParkingLot_company_id_key" UNIQUE ("company_id"),
    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TimelineObject" (
    "id" VARCHAR(255) NOT NULL,
    "user_text" VARCHAR(255) NOT NULL,
    "manager_text" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReservationTimelineObjects" (
    "status_code" VARCHAR(255) NOT NULL,
    "reservation_id" VARCHAR(255) NOT NULL,
    "timestamp" TIMESTAMP NOT NULL,

    CONSTRAINT "ReservationTimelineObjects_status_code_reservation_id_key" UNIQUE ("status_code", "reservation_id")
);

-- CreateTable
CREATE TABLE "ParkingSpot" (
    "id" VARCHAR(255) NOT NULL,
    "supported_vehicles" JSON NOT NULL,
    "total_spots" INTEGER NOT NULL,
    "used_spots" INTEGER NOT NULL,
    "start" INTEGER NOT NULL,
    "end" INTEGER NOT NULL,
    "parking_lot_id" VARCHAR(255) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Reservation" (
    "id" VARCHAR(255) NOT NULL,
    "conductor_phone" VARCHAR(255),
    "conductor_name" VARCHAR(255),
    "vehicle_id" VARCHAR(255),
    "parking_lot_id" VARCHAR(255) NOT NULL,
    "start_time" TIMESTAMP,
    "status" TEXT NOT NULL CHECK ("status" IN ('WAITING', 'DONE', 'CANCELED', 'ERROR')) DEFAULT 'WAITING',
    "end_time" TIMESTAMP,
    "duration" INTEGER,
    "checkin_code" VARCHAR(255),
    "checkout_code" VARCHAR(255),
    "internal_reference" VARCHAR(255),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "parking_spot_id" VARCHAR(255),
    "parking_spot_used" INTEGER,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Feedback" (
    "id" VARCHAR(255) NOT NULL,
    "parking_lot_id" VARCHAR(255) NOT NULL,
    "feedback_type" TEXT NOT NULL CHECK ("feedback_type" IN ('USABILITY', 'EASE_OF_USE', 'TECHNICAL_SUPPORT', 'USER_INTERFACE', 'APPLICATION_FUNCTIONALITY', 'OTHERS')),
    "feedback_text" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Favorites" (
    "parking_lot_id" VARCHAR(255) NOT NULL,
    "user_id" VARCHAR(255) NOT NULL,

    PRIMARY KEY ("parking_lot_id", "user_id")
);

-- CreateTable
CREATE TABLE "Conveniences" (
    "id" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Availability" (
    "id" VARCHAR(255) NOT NULL,
    "parking_lot_id" VARCHAR(255) NOT NULL,
    "weekday" TEXT NOT NULL CHECK ("weekday" IN ('SUNDAY', 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY')),
    "start_time" INTEGER NOT NULL,
    "end_time" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ConveniencesOnParkingLots" (
    "parking_lot_id" VARCHAR(255) NOT NULL,
    "conveniences_id" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("parking_lot_id", "conveniences_id")
);

-- CreateTable
CREATE TABLE "Company" (
    "id" VARCHAR(255) NOT NULL,
    "cnpj" VARCHAR(255),
    "name" VARCHAR(255),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Vehicle" (
    "id" VARCHAR(255) NOT NULL,
    "name" VARCHAR(60),
    "brand" VARCHAR(60),
    "plate" VARCHAR(60),
    "color" VARCHAR(60),
    "model" VARCHAR(45),
    "vehicle_type" TEXT NOT NULL CHECK ("vehicle_type" IN ('CAR', 'MOTORCYCLE', 'BICYCLE', 'ELECTRIC_CAR', 'ELECTRIC_MOTORCYCLE', 'ELECTRIC_BICYCLE')),
    "user_id" VARCHAR(255),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ResetPassword" ADD CONSTRAINT "ResetPassword_login_id_fkey" 
FOREIGN KEY ("login_id") REFERENCES "Login"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_login_id_fkey" 
FOREIGN KEY ("login_id") REFERENCES "Login"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParkingLot" ADD CONSTRAINT "ParkingLot_address_id_fkey" 
FOREIGN KEY ("address_id") REFERENCES "Address"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParkingLot" ADD CONSTRAINT "ParkingLot_company_id_fkey" 
FOREIGN KEY ("company_id") REFERENCES "Company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParkingLot" ADD CONSTRAINT "ParkingLot_login_id_fkey" 
FOREIGN KEY ("login_id") REFERENCES "Login"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReservationTimelineObjects" ADD CONSTRAINT "ReservationTimelineObjects_reservation_id_fkey" 
FOREIGN KEY ("reservation_id") REFERENCES "Reservation"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReservationTimelineObjects" ADD CONSTRAINT "ReservationTimelineObjects_status_code_fkey" 
FOREIGN KEY ("status_code") REFERENCES "TimelineObject"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParkingSpot" ADD CONSTRAINT "ParkingSpot_parking_lot_id_fkey" 
FOREIGN KEY ("parking_lot_id") REFERENCES "ParkingLot"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_parking_spot_id_fkey" 
FOREIGN KEY ("parking_spot_id") REFERENCES "ParkingSpot"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_vehicle_id_fkey" 
FOREIGN KEY ("vehicle_id") REFERENCES "Vehicle"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feedback" ADD CONSTRAINT "Feedback_parking_lot_id_fkey" 
FOREIGN KEY ("parking_lot_id") REFERENCES "ParkingLot"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorites" ADD CONSTRAINT "Favorites_parking_lot_id_fkey" 
FOREIGN KEY ("parking_lot_id") REFERENCES "ParkingLot"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorites" ADD CONSTRAINT "Favorites_user_id_fkey" 
FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Availability" ADD CONSTRAINT "Availability_parking_lot_id_fkey" 
FOREIGN KEY ("parking_lot_id") REFERENCES "ParkingLot"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ConveniencesOnParkingLots" ADD CONSTRAINT "ConveniencesOnParkingLots_conveniences_id_fkey" 
FOREIGN KEY ("conveniences_id") REFERENCES "Conveniences"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ConveniencesOnParkingLots" ADD CONSTRAINT "ConveniencesOnParkingLots_parking_lot_id_fkey" 
FOREIGN KEY ("parking_lot_id") REFERENCES "ParkingLot"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vehicle" ADD CONSTRAINT "Vehicle_user_id_fkey" 
FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

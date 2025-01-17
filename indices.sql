create index resetpassword_loginid_idx on "ResetPassword" using hash (login_id);

create index address_city_idx on "Address" using hash (city);

create index address_updatedat_idx on "Address" using btree ("updatedAt");

create index login_role_idx on "Login" using hash ("role");

create index reservation_status_idx on "Reservation" using hash (status);

create index address_city_idx on "Address" using hash (city);

create index reservation_vehicleid_idx on "Reservation" using hash (vehicle_id);
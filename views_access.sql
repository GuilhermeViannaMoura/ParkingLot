CREATE ROLE not_adm WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1
	PASSWORD '123';

GRANT SELECT ON login_view TO not_adm;
GRANT SELECT ON resetpassword_view TO not_adm;
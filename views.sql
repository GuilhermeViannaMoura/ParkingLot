-- View da tabela Login sem as informações sensíveis de senha e refresh_token
CREATE VIEW login_view AS
SELECT 
    "id",
    "email",
    "role",
    "deactivated",
    "createdAt",
    "updatedAt"
FROM 
    "Login";

-- View da tabela ResetPassword sem a informação sensível de reset_password_token
CREATE VIEW resetpassword_view AS
SELECT 
    "id",
    "login_id",
	"createdAt"
FROM 
    "ResetPassword";
	
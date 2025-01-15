/*
 
 Trigger para validar formato do CPF ao cadastrar um novo usuário.
 
*/

CREATE OR REPLACE FUNCTION valida_cpf()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT NEW."cpf" ~ '^[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}$' THEN
        RAISE EXCEPTION 'CPF inválido';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER valida_cpf
BEFORE INSERT OR UPDATE ON "User"
FOR EACH ROW
EXECUTE FUNCTION valida_cpf();


/*
 
 Trigger para validar formato do CNPJ ao cadastrar um novo fornecedor.
 
*/

CREATE OR REPLACE FUNCTION valida_cnpj()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT NEW."cnpj" ~ '^[0-9]{2}\.[0-9]{3}\.[0-9]{3}/[0-9]{4}-[0-9]{2}$' THEN
        RAISE EXCEPTION 'CNPJ inválido';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER valida_cnpj
BEFORE INSERT OR UPDATE ON "Company"
FOR EACH ROW
EXECUTE FUNCTION valida_cnpj();
CREATE OR REPLACE TRIGGER nuevoProductorLocalidad
INSTEAD OF INSERT ON Productores
FOR EACH ROW
DECLARE
    v_comunidadAutonoma VARCHAR2(50);
    v_localidad VARCHAR2(50);
BEGIN
    -- Extract the comunidadAutonoma value from the :NEW column
    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Vinos
    WHERE codigo_productor = :NEW.codigo;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            -- Handle the error case here
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || v_comunidadAutonoma);
    END CASE;

    BEGIN
        -- Use a nested block for exception handling
        EXECUTE IMMEDIATE 'INSERT INTO ' || v_localidad || '.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
        USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
    EXCEPTION
        WHEN OTHERS THEN
            -- Log the error or handle it appropriately
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;

CREATE OR REPLACE TRIGGER nuevaSucursalLocalidad
INSTEAD OF INSERT ON Sucursales
FOR EACH ROW
DECLARE
    v_localidad VARCHAR2(50);
BEGIN
    CASE
        WHEN :NEW.comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN :NEW.comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN :NEW.comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN :NEW.comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            -- Handle the error case here
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || :NEW.comunidadAutonoma);
    END CASE;

    EXECUTE IMMEDIATE 'INSERT INTO ' || v_localidad || '.Sucursal(codigo, nombre, ciudad, director, comunidadAutonoma) VALUES (:1, :2, :3, :4, :5)'
    USING :NEW.codigo, :NEW.nombre, :NEW.ciudad, :NEW.director, :NEW.comunidadAutonoma;
END;

CREATE OR REPLACE TRIGGER nuevoClienteLocalidad
INSTEAD OF INSERT ON Clientes
FOR EACH ROW
DECLARE
    v_localidad VARCHAR2(50);
BEGIN
    CASE
        WHEN :NEW.comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN :NEW.comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN :NEW.comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN :NEW.comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            -- Handle the error case here
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || :NEW.comunidadAutonoma);
    END CASE;

    EXECUTE IMMEDIATE 'INSERT INTO ' || v_localidad || '.Cliente(codigo, DNI, tipo, nombre, direccion, comunidadAutonoma) VALUES (:1, :2, :3, :4, :5, :6)'
    USING :NEW.codigo, :NEW.DNI, :NEW.tipo, :NEW.nombre, :NEW.direccion, :NEW.comunidadAutonoma;
END;


CREATE OR REPLACE TRIGGER nuevoEmpleadoLocalidad
INSTEAD OF INSERT ON Empleados
FOR EACH ROW
DECLARE
    v_comunidadAutonoma VARCHAR2(50);
    v_localidad VARCHAR2(50);
BEGIN
    -- Extract the comunidadAutonoma value from the :NEW column
    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Sucursales
    WHERE codigo = :NEW.codigo_sucursal;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            -- Handle the error case here
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || v_comunidadAutonoma);
    END CASE;

    BEGIN
        -- Use a nested block for exception handling
        EXECUTE IMMEDIATE 'INSERT INTO ' || v_localidad || '.Empleado(codigo, DNI, nombre, direccion, fechaDeComienzo, salario, trabajaPorLaSucursal, codigo_sucursal) VALUES (:1, :2, :3, :4, :5, :6, :7, :8)'
        USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion, :NEW.fechaDeComienzo, :NEW.salario, :NEW.trabajaPorLaSucursal, :NEW.codigo_sucursal;
    EXCEPTION
        WHEN OTHERS THEN
            -- Log the error or handle it appropriately
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;

CREATE OR REPLACE TRIGGER nuevoVinoLocalidad
INSTEAD OF INSERT ON Vinos
FOR EACH ROW
DECLARE
    v_localidad VARCHAR2(50);
BEGIN
    CASE
        WHEN :NEW.comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN :NEW.comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN :NEW.comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN :NEW.comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            -- Handle the error case here
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || :NEW.comunidadAutonoma);
    END CASE;

    EXECUTE IMMEDIATE 'INSERT INTO ' || v_localidad || '.Vino(codigo, marca, comunidadAutonoma, año, denominacionDeOrigen, graduacion, viñedoDeProcedencia, cantidadProducida, cantidadStock, codigo_productor, codigo_sucursal) VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11)'
    USING :NEW.codigo, :NEW.marca, :NEW.comunidadAutonoma, :NEW.año, :NEW.denominacionDeOrigen, :NEW.graduacion, :NEW.viñedoDeProcedencia, :NEW.cantidadProducida, :NEW.cantidadStock, :NEW.codigo_productor, :NEW.codigo_sucursal;
END;

CREATE OR REPLACE TRIGGER nuevoPideLocalidad
INSTEAD OF INSERT ON Pides
FOR EACH ROW
DECLARE
    v_comunidadAutonoma VARCHAR2(50);
    v_localidad VARCHAR2(50);
BEGIN
    -- Extract the comunidadAutonoma value from the :NEW column
    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Vinos
    WHERE codigo = :NEW.codigo_vino;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            -- Handle the error case here
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || v_comunidadAutonoma);
    END CASE;

    BEGIN
        -- Use a nested block for exception handling
        EXECUTE IMMEDIATE 'INSERT INTO ' || v_localidad || '.Pide(fecha, cantidad, codigo_vino, codigo_pedidor, codigo_entregador) VALUES (:1, :2, :3, :4, :5)'
        USING :NEW.fecha, :NEW.cantidad, :NEW.codigo_vino, :NEW.codigo_pedidor, :NEW.codigo_entregador;
    EXCEPTION
        WHEN OTHERS THEN
            -- Log the error or handle it appropriately
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;

CREATE OR REPLACE TRIGGER nuevoSuministroLocalidad
INSTEAD OF INSERT ON Suministros
FOR EACH ROW
DECLARE
    v_comunidadAutonoma VARCHAR2(50);
    v_localidad VARCHAR2(50);
BEGIN
    -- Extract the comunidadAutonoma value from the :NEW column
    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Clientes
    WHERE codigo = :NEW.codigo_cliente;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            -- Handle the error case here
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || v_comunidadAutonoma);
    END CASE;

    BEGIN
        -- Use a nested block for exception handling
        EXECUTE IMMEDIATE 'INSERT INTO ' || v_localidad || '.Suministro(cantidad, fecha, codigo_vino, codigo_cliente, codigo_sucursal) VALUES (:1, :2, :3, :4, :5)'
        USING :NEW.cantidad, :NEW.fecha, :NEW.codigo_vino, :NEW.codigo_cliente, :NEW.codigo_sucursal;
    EXCEPTION
        WHEN OTHERS THEN
            -- Log the error or handle it appropriately
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
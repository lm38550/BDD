------------------------------------CREATE----------------------------------------

CREATE OR REPLACE TRIGGER nuevoProductorLocalidad ----------------ERASMUS1-------------
AFTER INSERT ON Productor
FOR EACH ROW
BEGIN
    -- Use a nested block for exception handling    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus2.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus3.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus4.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error or handle it appropriately
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

CREATE OR REPLACE TRIGGER nuevoProductorLocalidad ----------------ERASMUS2-------------
AFTER INSERT ON Productor
FOR EACH ROW
BEGIN
    -- Use a nested block for exception handling    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus1.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus3.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus4.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error or handle it appropriately
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

CREATE OR REPLACE TRIGGER nuevoProductorLocalidad ----------------ERASMUS3-------------
AFTER INSERT ON Productor
FOR EACH ROW
BEGIN
    -- Use a nested block for exception handling    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus1.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus2.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus4.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error or handle it appropriately
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

CREATE OR REPLACE TRIGGER nuevoProductorLocalidad ----------------ERASMUS4-------------
AFTER INSERT ON Productor
FOR EACH ROW
BEGIN
    -- Use a nested block for exception handling    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus1.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus2.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
    
    EXECUTE IMMEDIATE 'INSERT INTO erasmus3.Productor(codigo, DNI, nombre, direccion) VALUES (:1, :2, :3, :4)'
    USING :NEW.codigo, :NEW.dni, :NEW.nombre, :NEW.direccion;
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error or handle it appropriately
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
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

----------------------------------------DELETE------------------------------------------------

CREATE OR REPLACE TRIGGER borrarProductorLocalidad ----------------ERASMUS1-------------
AFTER DELETE ON Productor
FOR EACH ROW
BEGIN
    -- Use a nested block for exception handling    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus2.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus3.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus4.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error or handle it appropriately
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

CREATE OR REPLACE TRIGGER borrarProductorLocalidad ----------------ERASMUS2-------------
AFTER DELETE ON Productor
FOR EACH ROW
BEGIN
    -- Use a nested block for exception handling    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus1.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus3.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus4.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error or handle it appropriately
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

CREATE OR REPLACE TRIGGER borrarProductorLocalidad ----------------ERASMUS3-------------
AFTER DELETE ON Productor
FOR EACH ROW
BEGIN
    -- Use a nested block for exception handling    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus1.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus2.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus4.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error or handle it appropriately
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

CREATE OR REPLACE TRIGGER borrarProductorLocalidad ----------------ERASMUS4-------------
AFTER DELETE ON Productor
FOR EACH ROW
BEGIN
    -- Use a nested block for exception handling    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus1.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus2.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
    EXECUTE IMMEDIATE 'DELETE FROM erasmus3.Productor WHERE codigo = :1'
        USING :OLD.codigo;
    
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error or handle it appropriately
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


CREATE OR REPLACE TRIGGER borrarEmpleadoLocalidad
INSTEAD OF DELETE ON Empleados
FOR EACH ROW
DECLARE
    v_comunidadAutonoma VARCHAR2(50);
    v_localidad VARCHAR2(50);
BEGIN
    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Sucursales
    WHERE codigo = :OLD.codigo_sucursal;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || v_comunidadAutonoma);
    END CASE;

    BEGIN
        EXECUTE IMMEDIATE 'DELETE FROM ' || v_localidad || '.Empleado WHERE codigo = :1'
        USING :OLD.codigo;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;

CREATE OR REPLACE TRIGGER borrarVinoLocalidad
INSTEAD OF DELETE ON Vinos
FOR EACH ROW
DECLARE
    v_localidad VARCHAR2(50);
BEGIN
    CASE
        WHEN :OLD.comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN :OLD.comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN :OLD.comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN :OLD.comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            -- Handle the error case here
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || :OLD.comunidadAutonoma);
    END CASE;

    EXECUTE IMMEDIATE 'DELETE FROM ' || v_localidad || '.Vino WHERE codigo = :1'
    USING :OLD.codigo;
END;

CREATE OR REPLACE TRIGGER borrarVinoLocalidad
INSTEAD OF DELETE ON Vinos
FOR EACH ROW
DECLARE
    v_localidad VARCHAR2(50);
BEGIN
    CASE
        WHEN :OLD.comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN :OLD.comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN :OLD.comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN :OLD.comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            -- Handle the error case here
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || :OLD.comunidadAutonoma);
    END CASE;

    EXECUTE IMMEDIATE 'DELETE FROM ' || v_localidad || '.Vino WHERE codigo = :1'
    USING :OLD.codigo;
END;

CREATE OR REPLACE TRIGGER borrarPideLocalidad
INSTEAD OF DELETE ON Pides
FOR EACH ROW
DECLARE
    v_comunidadAutonoma VARCHAR2(50);
    v_localidad VARCHAR2(50);
BEGIN
    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Vinos
    WHERE codigo = :OLD.codigo_vino;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || v_comunidadAutonoma);
    END CASE;

    BEGIN
        EXECUTE IMMEDIATE 'DELETE FROM ' || v_localidad || '.Pide WHERE codigo_vino = :1'
        USING :OLD.codigo_vino;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;


CREATE OR REPLACE TRIGGER borrarSuministroLocalidad
INSTEAD OF DELETE ON Suministros
FOR EACH ROW
DECLARE
    v_comunidadAutonoma VARCHAR2(50);
    v_localidad VARCHAR2(50);
BEGIN
    -- Extract the comunidadAutonoma value from the :OLD column
    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Clientes
    WHERE codigo = :OLD.codigo_cliente;

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
        EXECUTE IMMEDIATE 'DELETE FROM ' || v_localidad || '.Suministro WHERE codigo_vino = :1 AND codigo_cliente = :2'
        USING :OLD.codigo_vino, :OLD.codigo_cliente;
    EXCEPTION
        WHEN OTHERS THEN
            -- Log the error or handle it appropriately
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;

--------------------------------------MODIFICAR----------------------------------


CREATE OR REPLACE TRIGGER modificarSucursalLocalidad
INSTEAD OF UPDATE ON Sucursales
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

    EXECUTE IMMEDIATE 'UPDATE ' || v_localidad || '.Sucursal SET codigo = :1, nombre = :2, ciudad = :3, director = :4, comunidadAutonoma = :5 WHERE codigo = :1'
    USING :NEW.codigo, :NEW.nombre, :NEW.ciudad, :NEW.director, :NEW.comunidadAutonoma;
END;

CREATE OR REPLACE TRIGGER modificarEmpleadoLocalidad
INSTEAD OF UPDATE ON Empleados
FOR EACH ROW
DECLARE
    v_comunidadAutonoma VARCHAR2(50);
    v_localidad VARCHAR2(50);
BEGIN
    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Sucursales
    WHERE codigo = :NEW.codigo_sucursal;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || v_comunidadAutonoma);
    END CASE;

    BEGIN
        EXECUTE IMMEDIATE 'UPDATE ' || v_localidad || '.Empleado SET DNI = :1, nombre = :2, direccion = :3, fechaDeComienzo = :4, salario = :5, trabajaPorLaSucursal = :6, codigo_sucursal = :7 WHERE codigo = :8'
        USING :NEW.dni, :NEW.nombre, :NEW.direccion, :NEW.fechaDeComienzo, :NEW.salario, :NEW.trabajaPorLaSucursal, :NEW.codigo_sucursal, :OLD.codigo;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;

CREATE OR REPLACE TRIGGER modificarVinoLocalidad
INSTEAD OF UPDATE ON Vinos
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

    EXECUTE IMMEDIATE 'UPDATE ' || v_localidad || '.Vino SET codigo = :1, marca = :2, comunidadAutonoma = :3, año = :4, denominacionDeOrigen = :5, graduacion = :6, viñedoDeProcedencia = :7, cantidadProducida = :8, cantidadStock = :9, codigo_productor = :10, codigo_sucursal = :11 WHERE codigo = :1'
    USING :NEW.codigo, :NEW.marca, :NEW.comunidadAutonoma, :NEW.año, :NEW.denominacionDeOrigen, :NEW.graduacion, :NEW.viñedoDeProcedencia, :NEW.cantidadProducida, :NEW.cantidadStock, :NEW.codigo_productor, :NEW.codigo_sucursal;
END;

CREATE OR REPLACE TRIGGER modificarPideLocalidad
INSTEAD OF UPDATE ON Pides
FOR EACH ROW
DECLARE
    v_comunidadAutonoma VARCHAR2(50);
    v_localidad VARCHAR2(50);
BEGIN
    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Vinos
    WHERE codigo = :NEW.codigo_vino;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Invalid comunidadAutonoma: ' || v_comunidadAutonoma);
    END CASE;

    BEGIN
        EXECUTE IMMEDIATE 'UPDATE ' || v_localidad || '.Pide SET fecha = :1, cantidad = :2, codigo_vino = :3, codigo_pedidor = :4, codigo_entregador = :5 WHERE codigo_vino = :6'
        USING :NEW.fecha, :NEW.cantidad, :NEW.codigo_vino, :NEW.codigo_pedidor, :NEW.codigo_entregador, :OLD.codigo_vino;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;

CREATE OR REPLACE TRIGGER modificarSuministroLocalidad
INSTEAD OF UPDATE ON Suministros
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
        EXECUTE IMMEDIATE 'UPDATE ' || v_localidad || '.Suministro SET cantidad = :1, fecha = :2, codigo_vino = :3, codigo_cliente = :4, codigo_sucursal = :5 WHERE codigo_vino = :3 AND codigo_cliente = :4'
        USING :NEW.cantidad, :NEW.fecha, :NEW.codigo_vino, :NEW.codigo_cliente, :NEW.codigo_sucursal;
    EXCEPTION
        WHEN OTHERS THEN
            -- Log the error or handle it appropriately
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
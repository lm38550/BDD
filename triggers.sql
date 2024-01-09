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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || :NEW.comunidadAutonoma);
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || :NEW.comunidadAutonoma);
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || :NEW.comunidadAutonoma);
    END CASE;

    EXECUTE IMMEDIATE 'INSERT INTO ' || v_localidad || '.Vino(codigo, marca, comunidadAutonoma, año, denominacionDeOrigen, graduacion, viñedoDeProcedencia, cantidadProducida, cantidadStock, codigo_productor) VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10)'
    USING :NEW.codigo, :NEW.marca, :NEW.comunidadAutonoma, :NEW.año, :NEW.denominacionDeOrigen, :NEW.graduacion, :NEW.viñedoDeProcedencia, :NEW.cantidadProducida, :NEW.cantidadStock, :NEW.codigo_productor;
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
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
    v_exists NUMBER;
    v_localidad_cliente VARCHAR2(100);
    v_localidad_sucursal VARCHAR2(100);
    v_localidad_vino VARCHAR2(100);
BEGIN

    -- Check if the supply already exists
    SELECT COUNT(*)
    INTO v_exists
    FROM Suministros
    WHERE codigo_sucursal = :NEW.codigo_sucursal
      AND codigo_vino = :NEW.codigo_vino
      AND fecha = :NEW.fecha;

    SELECT localidad INTO v_localidad_cliente
    FROM (
        SELECT 'erasmus1' AS localidad FROM erasmus1.cliente WHERE codigo = :NEW.codigo_cliente
        UNION ALL
        SELECT 'erasmus2' AS localidad FROM erasmus2.cliente WHERE codigo = :NEW.codigo_cliente
        UNION ALL
        SELECT 'erasmus3' AS localidad FROM erasmus3.cliente WHERE codigo = :NEW.codigo_cliente
        UNION ALL
        SELECT 'erasmus4' AS localidad FROM erasmus4.cliente WHERE codigo = :NEW.codigo_cliente
    );

    SELECT localidad INTO v_localidad_sucursal
    FROM (
        SELECT 'erasmus1' AS localidad FROM erasmus1.sucursal WHERE codigo = :NEW.codigo_sucursal
        UNION ALL
        SELECT 'erasmus2' AS localidad FROM erasmus2.sucursal WHERE codigo = :NEW.codigo_sucursal
        UNION ALL
        SELECT 'erasmus3' AS localidad FROM erasmus3.sucursal WHERE codigo = :NEW.codigo_sucursal
        UNION ALL
        SELECT 'erasmus4' AS localidad FROM erasmus4.sucursal WHERE codigo = :NEW.codigo_sucursal
    );

    SELECT localidad INTO v_localidad_vino
    FROM (
        SELECT 'erasmus1' AS localidad FROM erasmus1.vino WHERE codigo = :NEW.codigo_vino
        UNION ALL
        SELECT 'erasmus2' AS localidad FROM erasmus2.vino WHERE codigo = :NEW.codigo_vino
        UNION ALL
        SELECT 'erasmus3' AS localidad FROM erasmus3.vino WHERE codigo = :NEW.codigo_vino
        UNION ALL
        SELECT 'erasmus4' AS localidad FROM erasmus4.vino WHERE codigo = :NEW.codigo_vino
    );

    IF v_exists > 0 AND v_localidad_cliente = v_localidad_sucursal AND v_localidad_sucursal = v_localidad_vino THEN
        -- Supply already exists; update the quantity
        EXECUTE IMMEDIATE 'UPDATE ' || v_localidad_cliente || '.suministro SET cantidad = cantidad + :1 WHERE codigo_sucursal = :2 AND codigo_vino = :3 AND fecha = :4'
        USING :NEW.cantidad, :NEW.codigo_sucursal, :NEW.codigo_vino, :NEW.fecha;
        DBMS_OUTPUT.PUT_LINE('Suministro actualizado');

    ELSIF v_localidad_cliente = v_localidad_sucursal AND v_localidad_sucursal = v_localidad_vino THEN
        -- Use EXECUTE IMMEDIATE for dynamic SQL
        EXECUTE IMMEDIATE 'INSERT INTO ' || v_localidad_cliente || '.suministro (cantidad, fecha, codigo_vino, codigo_cliente, codigo_sucursal)
        VALUES (:1, :2, :3, :4, :5)' USING :NEW.cantidad, :NEW.fecha, :NEW.codigo_vino, :NEW.codigo_cliente, :NEW.codigo_sucursal;
        DBMS_OUTPUT.PUT_LINE('Suministro creado');

    ELSIF v_localidad_cliente != v_localidad_sucursal AND v_localidad_sucursal != v_localidad_vino AND v_localidad_cliente != v_localidad_vino THEN
        DBMS_OUTPUT.PUT_LINE('Las localidades del Vino, Sucursal y Cliente no coinciden.');

    ELSIF v_localidad_cliente != v_localidad_sucursal AND v_localidad_sucursal != v_localidad_vino THEN
        DBMS_OUTPUT.PUT_LINE('Sólo puede hacer pedidos a una sucursal de su localidad. La sucursal seleccionada no distribuye el vino seleccionado.');

    ELSIF v_localidad_sucursal != v_localidad_vino AND v_localidad_cliente != v_localidad_vino THEN
        DBMS_OUTPUT.PUT_LINE('La sucursal seleccionada no distribuye el vino seleccionado. El vino solicitado no se encuentra en su localidad. Por lo tanto, no se puede pedir.');

    ELSIF v_localidad_cliente != v_localidad_sucursal AND v_localidad_cliente != v_localidad_vino THEN
        DBMS_OUTPUT.PUT_LINE('El vino solicitado no se encuentra en su localidad. Por lo tanto, no se puede pedir. La sucursal seleccionada no distribuye el vino seleccionado.');

    ELSIF v_localidad_cliente != v_localidad_vino THEN
        DBMS_OUTPUT.PUT_LINE('El vino solicitado no se encuentra en su localidad. Por lo tanto, no se puede pedir.');

    ELSIF v_localidad_cliente != v_localidad_sucursal THEN
        DBMS_OUTPUT.PUT_LINE('Sólo puede hacer pedidos a una sucursal que esté en su localidad.');

    ELSIF v_localidad_sucursal != v_localidad_vino THEN
    -- The localidades do not match between sucursal and vino
        DBMS_OUTPUT.PUT_LINE('El vino solicitada no es distribuida por la sucursal seleccionada');

    ELSE
        -- The localidades do not match between sucursal and vino
        DBMS_OUTPUT.PUT_LINE('Otro error. Compruebe los parámetros introducidos.');
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);    
END;





----------------------------------------DELETE-------------s-----------------------------------

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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || :OLD.comunidadAutonoma);
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || :OLD.comunidadAutonoma);
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
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
        WHEN :OLD.comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad := 'erasmus1';
        WHEN :OLD.comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad := 'erasmus2';
        WHEN :OLD.comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad := 'erasmus3';
        WHEN :OLD.comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad := 'erasmus4';
        ELSE
            -- Handle the error case here
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || :OLD.comunidadAutonoma);
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE('Localidad is : ' || v_localidad);
    DBMS_OUTPUT.PUT_LINE('director is : ' || :NEW.director);
    DBMS_OUTPUT.PUT_LINE('codigo is : ' || :NEW.codigo);

    EXECUTE IMMEDIATE 'UPDATE ' || v_localidad || '.Sucursal SET director = :1 WHERE codigo = :2'
    USING :NEW.director, :NEW.codigo;
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
    END CASE;

    BEGIN
        EXECUTE IMMEDIATE 'UPDATE ' || v_localidad || '.Empleado SET DNI = :1, nombre = :2, direccion = :3, fechaDeComienzo = :4, salario = :5, trabajaPorLaSucursal = :6, codigo_sucursal = :7 WHERE codigo = :8'
        USING :NEW.dni, :NEW.nombre, :NEW.direccion, :NEW.fechaDeComienzo, :NEW.salario, :NEW.trabajaPorLaSucursal, :NEW.codigo_sucursal, :OLD.codigo;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;

CREATE OR REPLACE TRIGGER modificarEmpleadoLocalidad
INSTEAD OF UPDATE ON Empleados
FOR EACH ROW
DECLARE
    v_comunidadAutonoma VARCHAR2(50);
    v_localidad_old VARCHAR2(50);
    v_localidad_new VARCHAR2(50);
BEGIN
    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Sucursales
    WHERE codigo = :OLD.codigo_sucursal;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad_old := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad_old := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad_old := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad_old := 'erasmus4';
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
    END CASE;

    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Sucursales
    WHERE codigo = :NEW.codigo_sucursal;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad_new := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad_new := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad_new := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad_new := 'erasmus4';
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
    END CASE;

    IF v_localidad_old = v_localidad_new THEN
        BEGIN
            EXECUTE IMMEDIATE 'UPDATE ' || v_localidad_new || '.Empleado SET DNI = :1, nombre = :2, direccion = :3, fechaDeComienzo = :4, salario = :5, trabajaPorLaSucursal = :6, codigo_sucursal = :7 WHERE codigo = :8'
            USING :NEW.dni, :NEW.nombre, :NEW.direccion, :NEW.fechaDeComienzo, :NEW.salario, :NEW.trabajaPorLaSucursal, :NEW.codigo_sucursal, :OLD.codigo;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END;
    ELSE
        BEGIN
            EXECUTE IMMEDIATE 'DELETE FROM ' || v_localidad_old || '.Empleado WHERE codigo = :1'
            USING :OLD.codigo;

            EXECUTE IMMEDIATE 'INSERT INTO ' || v_localidad_new || '.Empleado (DNI, nombre, direccion, fechaDeComienzo, salario, trabajaPorLaSucursal, codigo_sucursal, codigo) VALUES (:1, :2, :3, :4, :5, :6, :7, :8)'
            USING :NEW.dni, :NEW.nombre, :NEW.direccion, :NEW.fechaDeComienzo, :NEW.salario, :NEW.trabajaPorLaSucursal, :NEW.codigo_sucursal, :NEW.codigo;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END;
    END IF;
END;


CREATE OR REPLACE TRIGGER modificarEmpleadoLocalidad
INSTEAD OF UPDATE ON Empleados
FOR EACH ROW
DECLARE
    v_comunidadAutonoma VARCHAR2(50);
    v_localidad_old VARCHAR2(50);
    v_localidad_new VARCHAR2(50);
BEGIN
    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Sucursales
    WHERE codigo = :OLD.codigo_sucursal;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad_old := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad_old := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad_old := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad_old := 'erasmus4';
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
    END CASE;

    SELECT comunidadAutonoma INTO v_comunidadAutonoma
    FROM Sucursales
    WHERE codigo = :NEW.codigo_sucursal;

    CASE
        WHEN v_comunidadAutonoma IN ('Castilla-León', 'Castilla-La Mancha', 'Aragón', 'Madrid', 'La Rioja') THEN v_localidad_new := 'erasmus1';
        WHEN v_comunidadAutonoma IN ('Cataluña', 'Baleares', 'País Valenciano', 'Murcia') THEN v_localidad_new := 'erasmus2';
        WHEN v_comunidadAutonoma IN ('Galicia', 'Asturias', 'Cantabria', 'País Vasco', 'Navarra') THEN v_localidad_new := 'erasmus3';
        WHEN v_comunidadAutonoma IN ('Andalucía', 'Extremadura', 'Canarias', 'Ceuta', 'Melilla') THEN v_localidad_new := 'erasmus4';
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
    END CASE;

    IF v_localidad_old = v_localidad_new THEN
        BEGIN
            EXECUTE IMMEDIATE 'UPDATE ' || v_localidad_new || '.Empleado SET DNI = :1, nombre = :2, direccion = :3, fechaDeComienzo = :4, salario = :5, trabajaPorLaSucursal = :6, codigo_sucursal = :7 WHERE codigo = :8'
            USING :NEW.dni, :NEW.nombre, :NEW.direccion, :NEW.fechaDeComienzo, :NEW.salario, :NEW.trabajaPorLaSucursal, :NEW.codigo_sucursal, :OLD.codigo;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END;
    ELSE
        BEGIN
            EXECUTE IMMEDIATE 'DELETE FROM ' || v_localidad_old || '.Empleado WHERE codigo = :1'
            USING :OLD.codigo;

            EXECUTE IMMEDIATE 'INSERT INTO ' || v_localidad_new || '.Empleado (DNI, nombre, direccion, fechaDeComienzo, salario, trabajaPorLaSucursal, codigo_sucursal, codigo) VALUES (:1, :2, :3, :4, :5, :6, :7, :8)'
            USING :NEW.dni, :NEW.nombre, :NEW.direccion, :NEW.fechaDeComienzo, :NEW.salario, :NEW.trabajaPorLaSucursal, :NEW.codigo_sucursal, :NEW.codigo;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END;
    END IF;
END;


create or replace TRIGGER modificarVinoLocalidad
INSTEAD OF UPDATE ON Vinos
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || :OLD.comunidadAutonoma);
    END CASE;    

    EXECUTE IMMEDIATE 'UPDATE ' || v_localidad || '.Vino SET cantidadProducida = :1, cantidadStock = :2 WHERE codigo = :3'
    USING :NEW.cantidadProducida, :NEW.cantidadStock, :OLD.codigo;
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
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
            RAISE_APPLICATION_ERROR(-20001, 'comunidadAutonoma no valido: ' || v_comunidadAutonoma);
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

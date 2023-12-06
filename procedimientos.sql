CREATE OR REPLACE PROCEDURE nuevoEmpleado(
    p_codigo NUMBER,
    p_dni VARCHAR2,
    p_nombre VARCHAR2,
    p_direccion VARCHAR2,
    p_fechaDeComienzo DATE,
    p_salario NUMBER,
    p_codigo_sucursal NUMBER
) IS
BEGIN
    -- Insertar datos en la tabla de empleados
    INSERT INTO Empleados (
        codigo,
        DNI,
        nombre,
        direccion,
        fechaDeComienzo,
        salario,
        trabajaPorLaSucursal,
        codigo_sucursal
    ) VALUES (
        p_codigo,
        p_dni,
        p_nombre,
        p_direccion,
        p_fechaDeComienzo,
        p_salario,
        1,
        p_codigo_sucursal
    );

    DBMS_OUTPUT.PUT_LINE('Empleado creado exitosamente.');

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        -- Consider logging the error or handling it appropriately
END nuevoEmpleado;

CREATE OR REPLACE PROCEDURE bajaEmpleado(
    p_codigo NUMBER
) IS
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DELETE FROM Empleados WHERE codigo = :1' USING p_codigo;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Error deleting employee record');
    END;

    BEGIN
        EXECUTE IMMEDIATE 'UPDATE Sucursales SET Director = '''' WHERE Director = :1' USING p_codigo;
    END;
END bajaEmpleado;


CREATE OR REPLACE PROCEDURE modificarSalario(
    p_codigo NUMBER,
    p_salario NUMBER
) IS
    v_salarioAntiguo NUMBER;
BEGIN
    SELECT salario INTO v_salarioAntiguo
    FROM Empleados
    WHERE codigo = p_codigo;

    IF v_salarioAntiguo > p_salario THEN
        RAISE_APPLICATION_ERROR(-20001, 'El salario que has dado es más bajo que el salario actual');
    ELSE
        EXECUTE IMMEDIATE 'UPDATE Empleados SET salario = ' || p_salario || ' WHERE codigo = ' || p_codigo;
    END IF;
END modificarSalario;

CREATE OR REPLACE PROCEDURE transladarEmpleado(
    p_codigo NUMBER,
    p_codigo_sucursal NUMBER,
    p_direccion VARCHAR2 DEFAULT NULL
) IS
BEGIN
    BEGIN
        IF p_direccion IS NOT NULL THEN
            EXECUTE IMMEDIATE 'UPDATE Empleados SET codigo_sucursal = ' || p_codigo_sucursal || ', direccion = ''' || p_direccion || ''' WHERE codigo = ' || p_codigo;
        ELSE
            EXECUTE IMMEDIATE 'UPDATE Empleados SET codigo_sucursal = ' || p_codigo_sucursal || ' WHERE codigo = ' || p_codigo;
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Empleado with codigo ' || p_codigo || ' not found');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Error updating employee record');
    END;
END transladarEmpleado;

CREATE OR REPLACE PROCEDURE nuevaSucursal(
    p_codigo NUMBER,
    p_nombre VARCHAR2,
    p_ciudad VARCHAR2,
    p_comunidadAutonoma VARCHAR2,
    p_director NUMBER DEFAULT NULL
) IS
BEGIN
    INSERT INTO Sucursales (
        codigo,
        nombre,
        ciudad,
        comunidadAutonoma,
        director
    ) VALUES (
        p_codigo,
        p_nombre,
        p_ciudad,
        p_comunidadAutonoma,
        p_director
    );
    
    DBMS_OUTPUT.PUT_LINE('Sucursal creada exitosamente.');
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END nuevaSucursal;


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
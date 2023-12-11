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
    COMMIT;
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
    COMMIT;
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
    COMMIT;
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
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
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Sucursales WHERE director = p_director;

    IF v_count > 0 OR p_director IS NULL THEN
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
        END;
    ELSE
        BEGIN
            DBMS_OUTPUT.PUT_LINE('Director does not exist');
        END;
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END nuevaSucursal;



CREATE OR REPLACE PROCEDURE cambiarDirector(
    p_codigo_sucursal NUMBER,
    p_codigo_director VARCHAR2
) IS
    v_comunidad_autonoma VARCHAR(50);
BEGIN
    SELECT comunidadAutonoma INTO v_comunidad_autonoma
    FROM Sucursales
    WHERE codigo = p_codigo_sucursal;

    UPDATE Sucursales
    SET
        director = p_codigo_director
    WHERE
        codigo = p_codigo_sucursal
    AND
        comunidadAutonoma = v_comunidad_autonoma;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Director insertado o actualizado');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END cambiarDirector;


CREATE OR REPLACE PROCEDURE nuevoCliente(
    p_codigo NUMBER,
    p_DNI VARCHAR2,
    p_tipo VARCHAR2,
    p_nombre VARCHAR2,
    p_direccion VARCHAR2,
    p_comunidadAutonoma VARCHAR2
) IS
BEGIN
    INSERT INTO Clientes(
        codigo,
        DNI,
        tipo,
        nombre,
        direccion,
        comunidadAutonoma)
    VALUES(
        p_codigo,
        p_DNI,
        p_tipo,
        p_nombre,
        p_direccion,
        p_comunidadAutonoma);
    
    DBMS_OUTPUT.PUT_LINE('Cliente creada');
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END nuevoCliente;


create or replace PROCEDURE nuevoSuministro(
    p_codigo_cliente NUMBER,
    p_codigo_sucursal NUMBER,
    p_codigo_vino NUMBER,
    p_fecha_solicitud DATE,
    p_cantidad NUMBER
) IS
    v_max_date DATE;
    v_cantidad_producida NUMBER;
    v_cantidad_disponible NUMBER;
BEGIN
    SELECT MAX(FECHA) INTO v_max_date
    FROM Suministros
    WHERE CODIGO_CLIENTE = p_codigo_cliente;

    IF v_max_date IS NULL OR p_fecha_solicitud >= v_max_date THEN
        SELECT cantidadStock, cantidadProducida INTO v_cantidad_disponible, v_cantidad_producida
        FROM Vinos
        WHERE codigo = p_codigo_vino;

        IF v_cantidad_disponible >= p_cantidad THEN
            INSERT INTO Suministros (
                CANTIDAD,
                FECHA,
                CODIGO_VINO,
                CODIGO_CLIENTE,
                CODIGO_SUCURSAL
            ) VALUES (
                p_cantidad,
                p_fecha_solicitud,
                p_codigo_vino,
                p_codigo_cliente,
                p_codigo_sucursal
            );

            UPDATE Vinos SET cantidadStock = v_cantidad_disponible - p_cantidad, cantidadProducida = v_cantidad_producida WHERE codigo = p_codigo_vino;
        ELSE
            DBMS_OUTPUT.PUT_LINE('There is isufficient amount of Wine remaining for this order.');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('The new order date is earlier than existing orders. It cannot be created or updated.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END nuevoSuministro;


CREATE OR REPLACE PROCEDURE bajaSuministro(
    p_codigo_cliente NUMBER,
    p_codigo_sucursal NUMBER,
    p_codigo_vino NUMBER,
    p_fecha_Suministro DATE DEFAULT NULL
) AS
BEGIN
    IF p_fecha_Suministro IS NULL THEN
        DELETE FROM Suministros
        WHERE codigo_sucursal = p_codigo_sucursal
        AND codigo_vino = p_codigo_vino
        AND p_codigo_cliente = p_codigo_cliente;
    ELSE
        DELETE FROM Suministros
        WHERE codigo_sucursal = p_codigo_sucursal
        AND codigo_vino = p_codigo_vino
        AND fecha = p_fecha_Suministro
        AND p_codigo_cliente = p_codigo_cliente;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Suministro eliminado');
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END bajaSuministro;

create or replace PROCEDURE nuevaPedida(
    p_codigo_pedidor NUMBER,
    p_codigo_entregador NUMBER,
    p_codigo_vino NUMBER,
    p_fecha DATE,
    p_cantidad NUMBER
) IS
    v_localidadEntregador VARCHAR2(50);
    v_localidadVino VARCHAR2(50);
    v_cantidad_disponible NUMBER(10);
    v_cantidad_producida NUMBER;
BEGIN

SELECT localidad INTO v_localidadVino
FROM (
    SELECT 'erasmus1' AS localidad FROM erasmus1.vino WHERE codigo = p_codigo_vino
    UNION ALL
    SELECT 'erasmus2' AS localidad FROM erasmus2.vino WHERE codigo = p_codigo_vino
    UNION ALL
    SELECT 'erasmus3' AS localidad FROM erasmus3.vino WHERE codigo = p_codigo_vino
    UNION ALL
    SELECT 'erasmus4' AS localidad FROM erasmus4.vino WHERE codigo = p_codigo_vino
);

SELECT localidad INTO v_localidadEntregador
FROM (
    SELECT 'erasmus1' AS localidad FROM erasmus1.sucursal WHERE codigo = p_codigo_entregador
    UNION ALL
    SELECT 'erasmus2' AS localidad FROM erasmus2.sucursal WHERE codigo = p_codigo_entregador
    UNION ALL
    SELECT 'erasmus3' AS localidad FROM erasmus3.sucursal WHERE codigo = p_codigo_entregador
    UNION ALL
    SELECT 'erasmus4' AS localidad FROM erasmus4.sucursal WHERE codigo = p_codigo_entregador
);

    SELECT cantidadStock, cantidadProducida INTO v_cantidad_disponible, v_cantidad_producida
    FROM Vinos
    WHERE codigo = p_codigo_vino;

    IF v_localidadVino = v_localidadEntregador THEN
        IF v_cantidad_disponible >= p_cantidad THEN
            INSERT INTO Pides (
                codigo_pedidor,
                codigo_entregador,
                codigo_vino,
                fecha,
                cantidad
            ) VALUES (
                p_codigo_pedidor,
                p_codigo_entregador,
                p_codigo_vino,
                p_fecha,
                p_cantidad
            );
            COMMIT;

            UPDATE Vinos SET cantidadStock = v_cantidad_disponible - p_cantidad, cantidadProducida = v_cantidad_producida WHERE codigo = p_codigo_vino;

            DBMS_OUTPUT.PUT_LINE('Pedido creada exitosamente.');
            COMMIT;
        ELSE
            -- Handle the case where quantity is not sufficient
            DBMS_OUTPUT.PUT_LINE('Error: Insufficient quantity.');
        END IF;
    ELSE
        -- Handle the case where quantity is not sufficient
        DBMS_OUTPUT.PUT_LINE('Error: Este Sucursal no tiene el vino pedido.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END nuevaPedida;

create or replace PROCEDURE bajaPedida(
    p_codigo_pedidor NUMBER,
    p_codigo_entregador NUMBER,
    p_codigo_vino NUMBER,
    p_fecha DATE DEFAULT NULL
) IS
    v_cantidad NUMBER(10);
    v_cantidad_disponible NUMBER(10);
    v_cantidad_producida NUMBER(10);
BEGIN
    SELECT cantidadStock, cantidadProducida INTO v_cantidad_disponible, v_cantidad_producida
    FROM Vinos
    WHERE codigo = p_codigo_vino;

    IF p_fecha IS NULL THEN
        SELECT cantidad INTO v_cantidad
        FROM Pides
        WHERE codigo_pedidor = p_codigo_pedidor
        AND codigo_entregador = p_codigo_entregador
        AND codigo_vino = p_codigo_vino;

        DELETE FROM Pides WHERE
            codigo_pedidor = p_codigo_pedidor AND
            codigo_entregador = p_codigo_entregador AND
            codigo_vino = p_codigo_vino;
        
    ELSE
        SELECT cantidad INTO v_cantidad
        FROM Pides
        WHERE codigo_pedidor = p_codigo_pedidor
        AND codigo_entregador = p_codigo_entregador
        AND codigo_vino = p_codigo_vino
        AND fecha = p_fecha;

        DELETE FROM Pides WHERE
            codigo_pedidor = p_codigo_pedidor AND
            codigo_entregador = p_codigo_entregador AND
            codigo_vino = p_codigo_vino AND
            fecha = p_fecha;
    END IF;

    UPDATE Vinos SET cantidadStock = v_cantidad_disponible + v_cantidad, cantidadProducida = v_cantidad_producida WHERE codigo = p_codigo_vino;

    DBMS_OUTPUT.PUT_LINE('Pedido borada exitosamente.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END bajaPedida;

create or replace PROCEDURE nuevoVino(
    p_codigo NUMBER,
    p_marca VARCHAR2,
    p_año NUMBER,
    p_denominacionDeOrigen VARCHAR2 DEFAULT NULL,
    p_graduacion VARCHAR2,
    p_viñedoDeProcedencia VARCHAR2,
    p_comunidadAutonoma VARCHAR2,
    p_cantidadProducida NUMBER,
    p_codigo_productor NUMBER
) IS
    existeVino NUMBER;
    cantidadStockAntigua NUMBER;
    cantidadProducidaAntigua NUMBER;
BEGIN
    SELECT COUNT(*) INTO existeVino
    FROM Vinos
    WHERE codigo = p_codigo;

    IF existeVino > 0 THEN

        SELECT cantidadStock, cantidadProducida INTO cantidadStockAntigua, cantidadProducidaAntigua
        FROM Vinos
        WHERE codigo = p_codigo;

        UPDATE Vinos SET
            cantidadProducida = cantidadProducidaAntigua + p_cantidadProducida,
            cantidadStock = cantidadStockAntigua + p_cantidadProducida
        WHERE codigo = p_codigo;
        
        DBMS_OUTPUT.PUT_LINE('Cantidad añado al vino exitosamente.');
        COMMIT;
    ELSE
        INSERT INTO Vinos (
            codigo,
            marca,
            comunidadAutonoma,
            año,
            denominacionDeOrigen,
            graduacion,
            viñedoDeProcedencia,
            cantidadProducida,
            cantidadStock,
            codigo_productor
        ) VALUES (
            p_codigo,
            p_marca,
            p_comunidadAutonoma,
            p_año,
            p_denominacionDeOrigen,
            p_graduacion,
            p_viñedoDeProcedencia,
            p_cantidadProducida,
            p_cantidadProducida,
            p_codigo_productor
        );
        
        DBMS_OUTPUT.PUT_LINE('Vino creado exitosamente.');
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END nuevoVino;

create or replace PROCEDURE bajaVino(
    p_codigo NUMBER
) IS
    v_cantidad NUMBER;
BEGIN
    SELECT cantidadStock INTO v_cantidad
    FROM Vinos
    WHERE codigo = p_codigo;

    IF v_cantidad = 0 THEN
        DELETE FROM Vinos WHERE codigo = p_codigo;
        DBMS_OUTPUT.PUT_LINE('Pedido borrado exitosamente.');
        COMMIT;
    ELSE
        -- Gérez le cas où la quantité n'est pas suffisante
        DBMS_OUTPUT.PUT_LINE('Error: la cantidad no es 0.');
        -- Vous pouvez lever une exception ou la gérer différemment
        RAISE_APPLICATION_ERROR(-20001, 'La cantidad no es 0');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END bajaVino;

create or replace PROCEDURE nuevoProductor(
    p_codigo NUMBER,
    p_DNI VARCHAR2,
    p_nombre VARCHAR2,
    p_direccion VARCHAR2
) IS
BEGIN
    INSERT INTO Productor VALUES (p_codigo, p_DNI, p_nombre, p_direccion);

    DBMS_OUTPUT.PUT_LINE('Productor creado exitosamente.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END nuevoProductor;

create or replace PROCEDURE bajaProductor(
    p_codigo NUMBER
) IS
BEGIN
    DELETE FROM Productor WHERE codigo = p_codigo;

    DBMS_OUTPUT.PUT_LINE('Productor borado exitosamente.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END bajaProductor;

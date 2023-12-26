INSERT INTO Productores VALUES (1, 'a1', 'pablo', 'calle molinos 1');

INSERT INTO Sucursales VALUES (1, 'antonio', 'granada', NULL, 'Andalucía')

INSERT INTO Clientes VALUES (1, 'a2', 'b', 'fred', 'calle malaga', 'Andalucía')

INSERT INTO Empleados VALUES (1, 'a3', 'paul', 'calle granada', TO_DATE('20230901', 'YYYYMMDD'), 2000, 1, 1)

INSERT INTO Vinos VALUES (1, 'rioja', 'Andalucía', 2008, NULL, 'hola', 'adios', 10, 10, 1, 1)

INSERT INTO Pides VALUES (TO_DATE('20230901', 'YYYYMMDD'), 2, 1, 1, 1)

------INSERT INTO Suministros VALUES (2, TO_DATE('20230901', 'YYYYMMDD'), 1, 1, 1)

INSERT INTO Suministros VALUES (150, TO_DATE('20231104', 'YYYYMMDD'), 20, 3, 12)

EXECUTE nuevoSuministro (3, 12, 20, TO_DATE('20231104', 'YYYYMMDD'), 150); ---new supply
EXECUTE nuevoSuministro (3, 12, 20, TO_DATE('20231104', 'YYYYMMDD'), 1); ---add to supply

EXECUTE transladarEmpleado (1, 2); ---same localidad
EXECUTE transladarEmpleado (1, 4); ---different localidad

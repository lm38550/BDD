DROP VIEW Vinos;
DROP VIEW Suministros;
DROP VIEW Sucursales;
DROP VIEW Pides;
DROP VIEW Clientes;
DROP VIEW Empleados;

CREATE VIEW Empleados AS
SELECT * FROM erasmus1.Empleado
UNION
SELECT * FROM erasmus2.Empleado
UNION
SELECT * FROM erasmus3.Empleado
UNION
SELECT * FROM erasmus4.Empleado;

CREATE VIEW Clientes AS
SELECT * FROM erasmus1.Cliente
UNION
SELECT * FROM erasmus2.Cliente
UNION
SELECT * FROM erasmus3.Cliente
UNION
SELECT * FROM erasmus4.Cliente;

CREATE VIEW Pides AS
SELECT * FROM erasmus1.Pide
UNION
SELECT * FROM erasmus2.Pide
UNION
SELECT * FROM erasmus3.Pide
UNION
SELECT * FROM erasmus4.Pide;

CREATE VIEW Sucursales AS
SELECT * FROM erasmus1.Sucursal
UNION
SELECT * FROM erasmus2.Sucursal
UNION
SELECT * FROM erasmus3.Sucursal
UNION
SELECT * FROM erasmus4.Sucursal;

CREATE VIEW Suministros AS
SELECT * FROM erasmus1.Suministro
UNION
SELECT * FROM erasmus2.Suministro
UNION
SELECT * FROM erasmus3.Suministro
UNION
SELECT * FROM erasmus4.Suministro;

CREATE VIEW Vinos AS
SELECT * FROM erasmus1.Vino
UNION
SELECT * FROM erasmus2.Vino
UNION
SELECT * FROM erasmus3.Vino
UNION
SELECT * FROM erasmus4.Vino;
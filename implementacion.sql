DROP TABLE Suministro;
DROP TABLE Pide;
DROP TABLE Vino;
DROP TABLE Empleado;
DROP TABLE Cliente;
DROP TABLE Sucursal;
DROP TABLE Productor;

CREATE TABLE Productor(
   DNI VARCHAR2(50),
   nombre VARCHAR2(50)  NOT NULL,
   direccion VARCHAR2(500) NOT NULL,
   PRIMARY KEY(DNI)
);

CREATE TABLE Sucursal(
   codigo NUMBER(10),
   nombre VARCHAR2(50)  NOT NULL,
   ciudad VARCHAR2(50)  NOT NULL,
   director NUMBER(10),
   comunidadAutonoma VARCHAR2(50)  NOT NULL,
   PRIMARY KEY(codigo)
);

CREATE TABLE Cliente(
   DNI VARCHAR2(50) ,
   tipo VARCHAR2(50)  NOT NULL,
   nombre VARCHAR2(50)  NOT NULL,
   direccion VARCHAR2(500) NOT NULL,
   comunidadAutonoma VARCHAR2(50)  NOT NULL,
   codigo NUMBER(10) NOT NULL,
   PRIMARY KEY(DNI),
   FOREIGN KEY(codigo) REFERENCES Sucursal(codigo)
);

CREATE TABLE Empleado(
   codigo NUMBER(10),
   DNI VARCHAR2(50),
   nombre VARCHAR2(50)  NOT NULL,
   direccion VARCHAR2(500) NOT NULL,
   fechaDeComienzo DATE NOT NULL,
   salario NUMBER(19,4) NOT NULL,
   trabajaPorLaSucursal NUMBER(1) NOT NULL,
   codigo_sucursal NUMBER(10) NOT NULL,
   PRIMARY KEY(codigo),
   FOREIGN KEY(codigo_sucursal) REFERENCES Sucursal(codigo)
);

CREATE TABLE Vino(
   codigo NUMBER(10),
   marca VARCHAR2(50)  NOT NULL,
   comunidadAutonoma VARCHAR2(50)  NOT NULL,
   año NUMBER(10) NOT NULL,
   denominacionDeOrigen VARCHAR2(500),
   graduacion VARCHAR2(50)  NOT NULL,
   viñedoDeProcedencia VARCHAR2(50)  NOT NULL,
   cantidadProducida NUMBER(10) NOT NULL,
   cantidadStock NUMBER(10) NOT NULL,
   DNI VARCHAR2(50)  NOT NULL,
   codigo_sucursal NUMBER(10) NOT NULL,
   PRIMARY KEY(codigo),
   FOREIGN KEY(DNI) REFERENCES Productor(DNI),
   FOREIGN KEY(codigo_sucursal) REFERENCES Sucursal(codigo)
);

CREATE TABLE Pide(
   ID NUMBER(10),
   fecha DATE NOT NULL,
   cantidad NUMBER(10) NOT NULL,
   codigo_vino NUMBER(10) NOT NULL,
   codigo_pedidor NUMBER(10) NOT NULL,
   codigo_entregador NUMBER(10) NOT NULL,
   PRIMARY KEY(ID),
   FOREIGN KEY(codigo_vino) REFERENCES Vino(codigo),
   FOREIGN KEY(codigo_pedidor) REFERENCES Sucursal(codigo),
   FOREIGN KEY(codigo_entregador) REFERENCES Sucursal(codigo)
);

CREATE TABLE Suministro(
   ID NUMBER(10),
   cantidad NUMBER(10) NOT NULL,
   fecha DATE NOT NULL,
   codigo NUMBER(10) NOT NULL,
   DNI VARCHAR2(50)  NOT NULL,
   PRIMARY KEY(ID),
   FOREIGN KEY(codigo) REFERENCES Vino(codigo),
   FOREIGN KEY(DNI) REFERENCES Cliente(DNI)
);

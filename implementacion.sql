DROP TABLE Suministro;
DROP TABLE Pide;
DROP TABLE Vino;
DROP TABLE Empleado;
DROP TABLE Cliente;
DROP TABLE Sucursal;
DROP TABLE Productor;

CREATE TABLE Productor( --CD
   codigo NUMBER(10),
   DNI VARCHAR2(50) NOT NULL,
   nombre VARCHAR2(50)  NOT NULL,
   direccion VARCHAR2(500) NOT NULL,
   PRIMARY KEY(codigo)
);

CREATE TABLE Sucursal( --CM
   codigo NUMBER(10),
   nombre VARCHAR2(50)  NOT NULL,
   ciudad VARCHAR2(50)  NOT NULL,
   director NUMBER(10),
   comunidadAutonoma VARCHAR2(50)  NOT NULL,
   PRIMARY KEY(codigo)
);

CREATE TABLE Cliente( --CMD
   codigo NUMBER(10),
   DNI VARCHAR2(50) NOT NULL ,
   tipo VARCHAR2(50)  NOT NULL,
   nombre VARCHAR2(50)  NOT NULL,
   direccion VARCHAR2(500) NOT NULL,
   comunidadAutonoma VARCHAR2(50)  NOT NULL,
   PRIMARY KEY(codigo)
);

CREATE TABLE Empleado( --CMD
   codigo NUMBER(10),
   DNI VARCHAR2(50)  NOT NULL,
   nombre VARCHAR2(50)  NOT NULL,
   direccion VARCHAR2(500) NOT NULL,
   fechaDeComienzo DATE NOT NULL,
   salario NUMBER(19,4) NOT NULL,
   trabajaPorLaSucursal NUMBER(1) NOT NULL,
   codigo_sucursal NUMBER(10) NOT NULL,
   PRIMARY KEY(codigo),
   FOREIGN KEY(codigo_sucursal) REFERENCES Sucursal(codigo)
);

CREATE TABLE Vino( --CMD
   codigo NUMBER(10),
   marca VARCHAR2(50)  NOT NULL,
   comunidadAutonoma VARCHAR2(50)  NOT NULL,
   año NUMBER(10) NOT NULL,
   denominacionDeOrigen VARCHAR2(500),
   graduacion VARCHAR2(50)  NOT NULL,
   viñedoDeProcedencia VARCHAR2(50)  NOT NULL,
   cantidadProducida NUMBER(10) NOT NULL,
   cantidadStock NUMBER(10) NOT NULL,
   codigo_productor NUMBER(10)  NOT NULL,
   PRIMARY KEY(codigo),
   FOREIGN KEY(codigo_productor) REFERENCES Productor(codigo)
);

CREATE TABLE Pide( --CD
   fecha DATE NOT NULL,
   cantidad NUMBER(10) NOT NULL,
   codigo_vino NUMBER(10) NOT NULL,
   codigo_pedidor NUMBER(10) NOT NULL,
   codigo_entregador NUMBER(10) NOT NULL,
   FOREIGN KEY(codigo_vino) REFERENCES Vino(codigo),
   FOREIGN KEY(codigo_entregador) REFERENCES Sucursal(codigo)
);

CREATE TABLE Suministro( --CMD
   cantidad NUMBER(10) NOT NULL,
   fecha DATE NOT NULL,
   codigo_vino NUMBER(10) NOT NULL,
   codigo_cliente NUMBER(10)  NOT NULL,
   codigo_sucursal NUMBER(10) NOT NULL,
   FOREIGN KEY(codigo_vino) REFERENCES Vino(codigo),
   FOREIGN KEY(codigo_cliente) REFERENCES Cliente(codigo),
   FOREIGN KEY(codigo_sucursal) REFERENCES Sucursal(codigo)
);
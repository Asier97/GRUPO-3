DROP TABLE AdministraTrabajador CASCADE CONSTRAINTS;
DROP TABLE AdministraVehiculo CASCADE CONSTRAINTS;
DROP TABLE AdministraCentro CASCADE CONSTRAINTS;
DROP TABLE AdministraParte CASCADE CONSTRAINTS;
DROP TABLE Parte CASCADE CONSTRAINTS;
DROP TABLE Horas CASCADE CONSTRAINTS;
DROP TABLE Kilometros CASCADE CONSTRAINTS;
DROP TABLE Gastos CASCADE CONSTRAINTS;
DROP TABLE Vehiculo CASCADE CONSTRAINTS;
DROP TABLE Login CASCADE CONSTRAINTS;
DROP TABLE Logistica CASCADE CONSTRAINTS;
DROP TABLE Administrador CASCADE CONSTRAINTS;
DROP TABLE Trabajador CASCADE CONSTRAINTS;
DROP TABLE Centro CASCADE CONSTRAINTS;
DROP TABLE Direcciones CASCADE CONSTRAINTS;

CREATE TABLE Direcciones (
  Id_Dir NUMBER,
  Calle VARCHAR2 (40) NOT NULL,
  CP NUMBER (5) NOT NULL,
  Ciudad VARCHAR2 (30) NOT NULL,
  Provincia VARCHAR2 (30) NOT NULL,
  Portal NUMBER (3),
  Piso NUMBER (3),
  Mano VARCHAR2 (10),
  CONSTRAINT dir_id_pk PRIMARY KEY (Id_Dir)
);

CREATE TABLE Centro ( 
  Codigo NUMBER(2),
  Nombre VARCHAR2 (20) NOT NULL,
  Direccion NUMBER NOT NULL,
  Telefono NUMBER (9) NOT NULL,
  CONSTRAINT cen_cod_pk PRIMARY KEY (Codigo),
  CONSTRAINT cen_dir_fk FOREIGN KEY (Direccion) REFERENCES Direcciones(Id_dir)
);

CREATE TABLE Trabajador (
  DNI VARCHAR2 (9),
  Nombre VARCHAR2 (20) NOT NULL,
  Apellido1 VARCHAR2 (30) NOT NULL,
  Apellido2 VARCHAR2 (30) NOT NULL,
  Direccion NUMBER NOT NULL,
  Tel_Emp NUMBER (9) NOT NULL,
  Tel_Per NUMBER (9),
  Salario NUMBER (5,2),
  Fecha_Nac DATE,
  Centro NUMBER (2) NOT NULL,
  CONSTRAINT tra_dni_pk PRIMARY KEY (DNI),
  CONSTRAINT tra_cen_fk FOREIGN KEY (Centro) REFERENCES Centro(Codigo),
  CONSTRAINT tra_dir_fk FOREIGN KEY (Direccion) REFERENCES Direcciones(Id_dir)
);

CREATE TABLE Administrador (
  DNI VARCHAR2 (9),
  Id_Admin NUMBER NOT NULL,
  CONSTRAINT adm_dni_pk PRIMARY KEY (DNI),
  CONSTRAINT adm_dni_fk FOREIGN KEY (DNI) REFERENCES Trabajador(DNI)
);

CREATE TABLE Logistica (
  DNI VARCHAR2 (9),
  Id_Logistica NUMBER NOT NULL,
  Horas_extra NUMBER,
  CONSTRAINT logs_dni_pk PRIMARY KEY (DNI),
  CONSTRAINT logs_dni_fk FOREIGN KEY (DNI) REFERENCES Trabajador(DNI)
);

CREATE TABLE Login (
  DNI VARCHAR2(9),
  usuario VARCHAR2(20) NOT NULL,
  contraseña VARCHAR2(20) NOT NULL,
  CONSTRAINT logn_dni_pk PRIMARY KEY (DNI),
  CONSTRAINT logn_dni_fk FOREIGN KEY (DNI) REFERENCES Trabajador(DNI)  
);

CREATE TABLE Vehiculo (
  Matricula VARCHAR2(10),
  DNI VARCHAR2(9 )NOT NULL,
  Marca VARCHAR2(20),
  Modelo VARCHAR2(20),
  Peso NUMBER(5,3),
  CONSTRAINT veh_mat_pk PRIMARY KEY (Matricula),
  CONSTRAINT veh_dni_fk FOREIGN KEY (DNI) REFERENCES Logistica(DNI)
);

CREATE TABLE Gastos (
  ID_Gastos NUMBER,
  Gasto_gasoil NUMBER,
  Gasto_peaje NUMBER,
  Gasto_dietas NUMBER,
  Gasto_otros NUMBER,
  CONSTRAINT id_gas_pk PRIMARY KEY (ID_Gastos)
);

CREATE TABLE Kilometros (
  id_km NUMBER,
  Km_Inicio NUMBER,
  Km_Final NUMBER,
  CONSTRAINT km_hrs_pk PRIMARY KEY (id_km)
);

CREATE TABLE Horas (
  id_hr NUMBER,
  Hora_Ini NUMBER,
  Hora_Fn NUMBER,
  CONSTRAINT Hor_hrs_pk PRIMARY KEY (id_hr)
);

CREATE TABLE Parte (
  Albaran NUMBER,
  Matricula VARCHAR2(10) NOT NULL,
  DNI VARCHAR2 (9) NOT NULL,
  Kilometros NUMBER NOT NULL,
  Horas NUMBER NOT NULL,
  Validacion VARCHAR2(2) NOT NULL,
  Gastos NUMBER,
  Incidencias VARCHAR2(300),
  CONSTRAINT par_alb_pk PRIMARY KEY (Albaran),
  CONSTRAINT par_dni_fk FOREIGN KEY (DNI) REFERENCES Logistica(DNI),
  CONSTRAINT par_mat_fk FOREIGN KEY (Matricula) REFERENCES Vehiculo,
  CONSTRAINT par_val_ck CHECK (lower(Validacion) IN ('si','no')),
  CONSTRAINT par_gas_fk FOREIGN KEY (Gastos) REFERENCES Gastos(ID_Gastos),
  CONSTRAINT par_km_fk FOREIGN KEY (Kilometros) REFERENCES Kilometros(id_km),
  CONSTRAINT par_hr_fk FOREIGN KEY (Horas) REFERENCES Horas(id_hr)
);

CREATE TABLE AdministraParte (
  DNI VARCHAR2(9),
  Albaran NUMBER,
  CONSTRAINT ap_albdni_pk PRIMARY KEY (DNI,Albaran),
  CONSTRAINT ap_dni_fk FOREIGN KEY (DNI) REFERENCES Administrador(DNI),
  CONSTRAINT ap_alb_fk FOREIGN KEY (Albaran) REFERENCES Parte(Albaran)
);

CREATE TABLE AdministraCentro (
  DNI VARCHAR2(9),
  Codigo NUMBER(2),
  CONSTRAINT ac_albdni_pk PRIMARY KEY (DNI,Codigo),
  CONSTRAINT ac_dni_fk FOREIGN KEY (DNI) REFERENCES Administrador(DNI),
  CONSTRAINT ac_cod_fk FOREIGN KEY (Codigo) REFERENCES Centro(Codigo)
);

CREATE TABLE AdministraVehiculo (
  DNI VARCHAR2(9),
  Matricula VARCHAR2(10),
  CONSTRAINT av_albdni_pk PRIMARY KEY (DNI,Matricula),
  CONSTRAINT av_dni_fk FOREIGN KEY (DNI) REFERENCES Administrador(DNI),
  CONSTRAINT av_mat_fk FOREIGN KEY (Matricula) REFERENCES Vehiculo(Matricula)
);

CREATE TABLE AdministraTrabajador (
  DNI_Trab VARCHAR2(9),
  DNI_Admin VARCHAR2(9),
  CONSTRAINT at_albdni_pk PRIMARY KEY (DNI_Trab,DNI_Admin),
  CONSTRAINT at_dnit_fk FOREIGN KEY (DNI_Trab) REFERENCES Trabajador(DNI),
  CONSTRAINT at_dnia_fk FOREIGN KEY (DNI_Admin) REFERENCES Administrador(DNI)
);













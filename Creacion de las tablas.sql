
--Definición de Esquema (DDL - Tablas y Restricciones)


USE InventarioComputadoras;
GO

/* =========================================================
   1. TABLAS INDEPENDIENTES / MAESTRAS
   ========================================================= */

-- Dependencia
IF OBJECT_ID('Dependencia', 'U') IS NULL
BEGIN
    CREATE TABLE Dependencia (
        ID_Dependencia INT PRIMARY KEY,
        Nombre_Dependencia NVARCHAR(100) NOT NULL UNIQUE
    );
END;

-- Usuario_Sistema
IF OBJECT_ID('Usuario_Sistema', 'U') IS NULL
BEGIN
    CREATE TABLE Usuario_Sistema (
        ID_Usuario INT PRIMARY KEY,
        Nombre_Usuario NVARCHAR(80) NOT NULL,
        ID_Dependencia INT NOT NULL,
        CONSTRAINT FK_Usuario_Dependencia FOREIGN KEY (ID_Dependencia) REFERENCES Dependencia(ID_Dependencia)
    );
END;

-- Sistema_Operativo
IF OBJECT_ID('Sistema_Operativo', 'U') IS NULL
BEGIN
    CREATE TABLE Sistema_Operativo (
        ID_SO INT PRIMARY KEY,
        Nombre_sistema_Operativo NVARCHAR(50) NOT NULL,
        Licencia_Sistema_OP NVARCHAR(100) NULL
    );
END;

-- Procesador
IF OBJECT_ID('Procesador', 'U') IS NULL
BEGIN
    CREATE TABLE Procesador (
        cod_Procesador INT PRIMARY KEY,
        Modelo_Procesador NVARCHAR(50) NOT NULL,
        Velocidad_Procesador DECIMAL(4,2) NOT NULL
    );
END;

-- GPU
IF OBJECT_ID('GPU', 'U') IS NULL
BEGIN
    CREATE TABLE GPU (
        ID_GPU INT PRIMARY KEY,
        Modelo_GPU NVARCHAR(50) NOT NULL,
        Memoria_GPU INT NOT NULL
    );
END;

-- Acceso_Remoto
IF OBJECT_ID('Acceso_Remoto', 'U') IS NULL
BEGIN
    CREATE TABLE Acceso_Remoto (
        ID_Anydesk INT PRIMARY KEY,
        Cod_Anydesk NVARCHAR(50) NOT NULL UNIQUE,
        Contra_Anydesk NVARCHAR(50) NOT NULL
    );
END;

-- Mouse
IF OBJECT_ID('Mouse', 'U') IS NULL
BEGIN
    CREATE TABLE Mouse (
        N_serie_Mouse NVARCHAR(50) PRIMARY KEY,
        Marca_Mouse NVARCHAR(50) NOT NULL
    );
END;

-- Teclado
IF OBJECT_ID('Teclado', 'U') IS NULL
BEGIN
    CREATE TABLE Teclado (
        N_serie_teclado NVARCHAR(50) PRIMARY KEY,
        Marca_Teclado NVARCHAR(50) NOT NULL
    );
END;

-- Monitor
IF OBJECT_ID('Monitor', 'U') IS NULL
BEGIN
    CREATE TABLE Monitor (
        N_serie_Monitor NVARCHAR(50) PRIMARY KEY,
        Modelo_Monitor NVARCHAR(50) NOT NULL,
        Marca_Monitor NVARCHAR(50) NOT NULL
    );
END;

-- Parlante
IF OBJECT_ID('Parlante', 'U') IS NULL
BEGIN
    CREATE TABLE Parlante (
        N_serie_Parlante NVARCHAR(50) PRIMARY KEY,
        Marca_Parlante NVARCHAR(50) NOT NULL
    );
END;

-- Software
IF OBJECT_ID('Software', 'U') IS NULL
BEGIN
    CREATE TABLE Software (
        ID_software INT PRIMARY KEY,
        Categoria NVARCHAR(30) NOT NULL,
        nombre_software NVARCHAR(80) NOT NULL
    );
END;

/* =========================================================
   2. TABLA CENTRAL PRINCIPAL
   ========================================================= */

-- Equipo
IF OBJECT_ID('Equipo', 'U') IS NULL
BEGIN
    CREATE TABLE Equipo (
        N_serie NVARCHAR(50) PRIMARY KEY,
        Marca_Modelo NVARCHAR(100) NOT NULL,
        tipo_Hardware NVARCHAR(20) NOT NULL,
        Ram_GB INT NOT NULL,
        Unidad_CD BIT NOT NULL,
        Regulador BIT NOT NULL,
        Observacion NVARCHAR(MAX) NULL,
        Estado NVARCHAR(15) NOT NULL,
        ID_SO INT NOT NULL,
        ID_GPU INT NOT NULL,
        cod_Procesador INT NOT NULL,
        ID_Anydesk INT NULL,
        N_serie_Mouse NVARCHAR(50) NULL,
        N_serie_teclado NVARCHAR(50) NULL,
        N_serie_Monitor NVARCHAR(50) NULL,
        N_serie_Parlante NVARCHAR(50) NULL,

        CONSTRAINT UQ_Equipo_Mouse UNIQUE (N_serie_Mouse),
        CONSTRAINT UQ_Equipo_Teclado UNIQUE (N_serie_teclado),
        CONSTRAINT UQ_Equipo_Monitor UNIQUE (N_serie_Monitor),

        CONSTRAINT FK_Equipo_SO FOREIGN KEY (ID_SO) REFERENCES Sistema_Operativo(ID_SO),
        CONSTRAINT FK_Equipo_GPU FOREIGN KEY (ID_GPU) REFERENCES GPU(ID_GPU),
        CONSTRAINT FK_Equipo_Procesador FOREIGN KEY (cod_Procesador) REFERENCES Procesador(cod_Procesador),
        CONSTRAINT FK_Equipo_Anydesk FOREIGN KEY (ID_Anydesk) REFERENCES Acceso_Remoto(ID_Anydesk),
        CONSTRAINT FK_Equipo_Mouse FOREIGN KEY (N_serie_Mouse) REFERENCES Mouse(N_serie_Mouse),
        CONSTRAINT FK_Equipo_Teclado FOREIGN KEY (N_serie_teclado) REFERENCES Teclado(N_serie_teclado),
        CONSTRAINT FK_Equipo_Monitor FOREIGN KEY (N_serie_Monitor) REFERENCES Monitor(N_serie_Monitor),
        CONSTRAINT FK_Equipo_Parlante FOREIGN KEY (N_serie_Parlante) REFERENCES Parlante(N_serie_Parlante)
    );
END;

-- Índice único condicional / filtrado para Parlantes (permite múltiples NULLs)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'UQ_Equipo_Parlante' AND object_id = OBJECT_ID('Equipo'))
BEGIN
    CREATE UNIQUE INDEX UQ_Equipo_Parlante ON Equipo(N_serie_Parlante) 
    WHERE N_serie_Parlante IS NOT NULL;
END;

/* =========================================================
   3. TABLAS DEPENDIENTES Y DE CONTROL
   ========================================================= */

-- Disco_Duro
IF OBJECT_ID('Disco_Duro', 'U') IS NULL
BEGIN
    CREATE TABLE Disco_Duro (
        id_Disco INT PRIMARY KEY,
        Cap_Disco INT NOT NULL,
        Marca_Disco NVARCHAR(50) NOT NULL,
        Tipo_Disco NVARCHAR(20) NOT NULL,
        N_serie NVARCHAR(50) NULL,
        CONSTRAINT FK_Disco_Equipo FOREIGN KEY (N_serie) REFERENCES Equipo(N_serie) ON DELETE SET NULL
    );
END;

-- Equipo_Software (Relación Muchos a Muchos)
IF OBJECT_ID('Equipo_Software', 'U') IS NULL
BEGIN
    CREATE TABLE Equipo_Software (
        ID_Equipo_Software INT IDENTITY(1,1) PRIMARY KEY,
        ID_software INT NOT NULL,
        N_serie NVARCHAR(50) NOT NULL,
        CONSTRAINT FK_EquipoSoftware_Software FOREIGN KEY (ID_software) REFERENCES Software(ID_software),
        CONSTRAINT FK_EquipoSoftware_Equipo FOREIGN KEY (N_serie) REFERENCES Equipo(N_serie) ON DELETE CASCADE,
        CONSTRAINT UQ_EquipoSoftware UNIQUE (N_serie, ID_software)
    );
END;

-- Fic_Inventario_Equipo
IF OBJECT_ID('Fic_Inventario_Equipo', 'U') IS NULL
BEGIN
    CREATE TABLE Fic_Inventario_Equipo (
        ID_Inventario INT IDENTITY(1,1) PRIMARY KEY,
        fecha DATE NOT NULL,
        cod_Tecnologia NVARCHAR(50) NOT NULL,
        cod_Almacen NVARCHAR(50) NOT NULL,
        ID_Usuario INT NOT NULL,
        N_serie NVARCHAR(50) NOT NULL,
        CONSTRAINT FK_Ficha_Usuario FOREIGN KEY (ID_Usuario) REFERENCES Usuario_Sistema(ID_Usuario),
        CONSTRAINT FK_Ficha_Equipo FOREIGN KEY (N_serie) REFERENCES Equipo(N_serie) ON DELETE CASCADE
    );
END;
GO
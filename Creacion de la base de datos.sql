 -- Creación de la Base de Datos


IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'InventarioComputadoras')
BEGIN
    CREATE DATABASE InventarioComputadoras
    ON PRIMARY (
        NAME = InventarioComputadoras_Data,
        FILENAME = 'C:\SQL_Data\InventarioComputadoras.mdf',
        SIZE = 100 MB,
        MAXSIZE = 1 GB,
        FILEGROWTH = 50 MB
    )
    LOG ON (
        NAME = InventarioComputadoras_Log,
        FILENAME = 'C:\SQL_Data\InventarioComputadoras_log.ldf',
        SIZE = 50 MB,
        MAXSIZE = 500 MB,
        FILEGROWTH = 25 MB
    );
    PRINT 'Base de datos "InventarioComputadoras" creada exitosamente.';
END
ELSE
BEGIN
    PRINT 'La base de datos ya existe.';
END
GO
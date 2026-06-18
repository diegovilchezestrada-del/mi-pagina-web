-- ============================================================
-- BASE DE DATOS: UPLA - GRADOS Y TÍTULOS DE PREGRADO
-- Normalización 3FN - Reglamento General de Grados y Títulos
-- Motor: SQL Server 2021
-- Autor: Ing. Raúl Fernández Bejarano
-- Fecha: 02/06/2026
-- ============================================================

USE master;
GO

-- ============================================================
-- 1. CREAR BASE DE DATOS
-- ============================================================
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'GradosTitulos')
BEGIN
    ALTER DATABASE GradosTitulos SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE GradosTitulos;
END
GO

CREATE DATABASE GradosTitulos
ON PRIMARY (
    NAME     = GradosTitulos_Data,
    FILENAME = 'D:\BaseDatos2026\GradosTitulos_data.mdf',
    SIZE     = 20MB,
    MAXSIZE  = 20GB,
    FILEGROWTH = 5MB
)
LOG ON (
    NAME     = GradosTitulos_Log,
    FILENAME = 'D:\BaseDatos2026\GradosTitulos_log.ldf',
    SIZE     = 6MB,
    MAXSIZE  = 2GB,
    FILEGROWTH = 2MB
);
GO

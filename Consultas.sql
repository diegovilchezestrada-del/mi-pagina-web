
--  (Agregación y Consultas)


USE InventarioComputadoras;
GO

/*=========================================================
CASO 1: Dependencias registradas
=========================================================*/
SELECT DISTINCT D.Nombre_Dependencia 
FROM Dependencia D;
GO

/*=========================================================
CASO 2: Usuarios registrados
=========================================================*/
SELECT Nombre_Usuario 
FROM Usuario_Sistema;
GO

/*=========================================================
CASO 3: Equipos tecnológicos
=========================================================*/
SELECT * FROM Equipo;
GO

/*=========================================================
CASO 4: Nombres de dependencias
=========================================================*/
SELECT Nombre_Dependencia 
FROM Dependencia;
GO

/*=========================================================
CASO 5: Usuario y su dependencia
=========================================================*/
SELECT U.Nombre_Usuario,
       D.Nombre_Dependencia
FROM Usuario_Sistema U
INNER JOIN Dependencia D ON U.ID_Dependencia = D.ID_Dependencia;
GO

/*=========================================================
CASO 6: Equipos tipo LAPTOP
=========================================================*/
SELECT * FROM Equipo
WHERE tipo_Hardware = 'Laptop';
GO

/*=========================================================
CASO 7: Equipos marca HP
=========================================================*/
SELECT * FROM Equipo
WHERE Marca_Modelo LIKE 'HP%';
GO

/*=========================================================
CASO 8: Equipos en estado BUENO
=========================================================*/
SELECT * FROM Equipo
WHERE Estado = 'Bueno';
GO

/*=========================================================
CASO 9: Equipos con GPU
=========================================================*/
SELECT * FROM Equipo
WHERE ID_GPU IS NOT NULL;
GO

/*=========================================================
CASO 10: Equipos sin GPU
=========================================================*/
SELECT * FROM Equipo
WHERE ID_GPU IS NULL;
GO

/*=========================================================
CASO 11: Equipos ordenados por marca
=========================================================*/
SELECT * FROM Equipo
ORDER BY Marca_Modelo ASC;
GO

/*=========================================================
CASO 12: Equipos ordenados por fecha
=========================================================*/
SELECT E.N_serie,
       E.Marca_Modelo,
       F.fecha
FROM Equipo E
INNER JOIN Fic_Inventario_Equipo F ON E.N_serie = F.N_serie
ORDER BY F.fecha DESC;
GO

/*=========================================================
CASO 13: Usuarios que empiezan con U
=========================================================*/
SELECT * FROM Usuario_Sistema
WHERE Nombre_Usuario LIKE 'U%';
GO

/*=========================================================
CASO 14: Modelos que contienen "10"
=========================================================*/
SELECT * FROM Equipo
WHERE Marca_Modelo LIKE '%10%';
GO

/*=========================================================
CASO 15: RAM 16 GB
=========================================================*/
SELECT * FROM Equipo
WHERE Ram_GB = 16;
GO

/*=========================================================
CASO 16: Equipos con disco SSD
=========================================================*/
SELECT E.N_serie,
       D.Marca_Disco,
       D.Cap_Disco
FROM Equipo E
INNER JOIN Disco_Duro D ON E.N_serie = D.N_serie
WHERE D.Tipo_Disco = 'SSD';
GO

/*=========================================================
CASO 17: Total de equipos
=========================================================*/
SELECT COUNT(*) AS Total_Equipos 
FROM Equipo;
GO

/*=========================================================
CASO 18: Total de usuarios
=========================================================*/
SELECT COUNT(*) AS Total_Usuarios 
FROM Usuario_Sistema;
GO

/*=========================================================
CASO 19: Equipos por dependencia
=========================================================*/
SELECT D.Nombre_Dependencia,
       COUNT(*) AS Cantidad_Equipos
FROM Fic_Inventario_Equipo F
INNER JOIN Usuario_Sistema U ON F.ID_Usuario = U.ID_Usuario
INNER JOIN Dependencia D ON U.ID_Dependencia = D.ID_Dependencia
GROUP BY D.Nombre_Dependencia;
GO

/*=========================================================
CASO 20: Total laptops
=========================================================*/
SELECT COUNT(*) AS Total_Laptops 
FROM Equipo
WHERE tipo_Hardware = 'Laptop';
GO

/*=========================================================
CASO 21: Partes del equipo
=========================================================*/
SELECT E.N_serie,
       M.Marca_Mouse,
       T.Marca_Teclado,
       MO.Modelo_Monitor,
       P.Marca_Parlante
FROM Equipo E
LEFT JOIN Mouse M ON E.N_serie_Mouse = M.N_serie_Mouse
LEFT JOIN Teclado T ON E.N_serie_teclado = T.N_serie_teclado
LEFT JOIN Monitor MO ON E.N_serie_Monitor = MO.N_serie_Monitor
LEFT JOIN Parlante P ON E.N_serie_Parlante = P.N_serie_Parlante;
GO

/*=========================================================
CASO 22: Monitores
=========================================================*/
SELECT * FROM Monitor;
GO

/*=========================================================
CASO 23: Software
=========================================================*/
SELECT * FROM Software;
GO

/*=========================================================
CASO 24: Software de diseño
=========================================================*/
SELECT * FROM Software
WHERE Categoria = 'Diseño';
GO

/*=========================================================
CASO 25: Software por equipo
=========================================================*/
SELECT E.N_serie,
       S.nombre_software
FROM Equipo E
INNER JOIN Equipo_Software ES ON E.N_serie = ES.N_serie
INNER JOIN Software S ON ES.ID_software = S.ID_software
ORDER BY E.N_serie;
GO

/*=========================================================
CASO 26: Sistemas operativos
=========================================================*/
SELECT * FROM Sistema_Operativo;
GO

/*=========================================================
CASO 27: Equipos con Windows 10
=========================================================*/
SELECT E.N_serie,
       SO.Nombre_sistema_Operativo
FROM Equipo E
INNER JOIN Sistema_Operativo SO ON E.ID_SO = SO.ID_SO
WHERE SO.Nombre_sistema_Operativo LIKE '%Windows 10%';
GO

/*=========================================================
CASO 28: Accesos remotos
=========================================================*/
SELECT * FROM Acceso_Remoto;
GO

/*=========================================================
CASO 29: Código AnyDesk por equipo
=========================================================*/
SELECT E.N_serie,
       A.Cod_Anydesk
FROM Equipo E
INNER JOIN Acceso_Remoto A ON E.ID_Anydesk = A.ID_Anydesk;
GO

/*=========================================================
CASO 30: Equipos de Contabilidad
=========================================================*/
SELECT E.N_serie,
       D.Nombre_Dependencia
FROM Equipo E
INNER JOIN Fic_Inventario_Equipo F ON E.N_serie = F.N_serie
INNER JOIN Usuario_Sistema U ON F.ID_Usuario = U.ID_Usuario
INNER JOIN Dependencia D ON U.ID_Dependencia = D.ID_Dependencia
WHERE D.Nombre_Dependencia = 'Contabilidad';
GO
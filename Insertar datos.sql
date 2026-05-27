
- Poblado de Datos (DML - Insertar datos)


USE InventarioComputadoras;
GO

/* =========================================================
   DEPENDENCIA
   ========================================================= */
INSERT INTO Dependencia (ID_Dependencia, Nombre_Dependencia) VALUES
(1, 'Contabilidad'),(2, 'Sistemas'),(3, 'RRHH'),(4, 'Ventas'),(5, 'Logistica'),
(6, 'Marketing'),(7, 'Direccion'),(8, 'Almacen'),(9, 'Finanzas'),(10, 'Soporte'),
(11, 'Produccion'),(12, 'Calidad'),(13, 'Tesoreria'),(14, 'Legal'),(15, 'Compras'),
(16, 'I+D'),(17, 'AtencionCliente'),(18, 'Seguridad'),(19, 'Capacitacion'),(20, 'Proyectos'),
(21, 'Auditoria'),(22, 'Comunicaciones'),(23, 'Bodega'),(24, 'Importaciones'),(25, 'Exportaciones'),
(26, 'ServicioMedico'),(27, 'Transporte'),(28, 'Limpieza'),(29, 'Cafeteria'),(30, 'Diseno'),
(31, 'Redes'),(32, 'BasesDatos'),(33, 'SeguridadInfo'),(34, 'Infraestructura'),(35, 'Documentacion'),
(36, 'Archivo'),(37, 'Facturacion'),(38, 'Cobranzas'),(39, 'ControlInterno'),(40, 'Riesgos'),
(41, 'Cumplimiento'),(42, 'Sostenibilidad'),(43, 'Innovacion'),(44, 'RelPublicas'),(45, 'ComercioExt'),
(46, 'Franquicias'),(47, 'Ecommerce'),(48, 'DataScience'),(49, 'Inteligencia'),(50, 'Transformacion');
GO

/* =========================================================
   USUARIO
   ========================================================= */
INSERT INTO Usuario_Sistema (ID_Usuario, Nombre_Usuario, ID_Dependencia) VALUES
(1, 'juan.perez', 1),(2, 'maria.gomez', 2),(3, 'luis.ramirez', 3),(4, 'ana.torres', 4),(5, 'carlos.sanchez', 5),
(6, 'jessica.ruiz', 6),(7, 'pedro.morales', 7),(8, 'lucia.vargas', 8),(9, 'diego.fernandez', 9),(10, 'karla.castillo', 10),
(11, 'andres.perez', 11),(12, 'sofia.reyes', 12),(13, 'miguel.quispe', 13),(14, 'elena.huaman', 14),(15, 'roberto.choque', 15),
(16, 'fernanda.lopez', 16),(17, 'ricardo.diaz', 17),(18, 'valentina.cruz', 18),(19, 'sebastian.vega', 19),(20, 'camila.soto', 20),
(21, 'felipe.gonzalez', 21),(22, 'daniela.mena', 22),(23, 'matias.rojas', 23),(24, 'paulina.contreras', 24),(25, 'nicolas.ferrada', 25),
(26, 'constanza.uribe', 26),(27, 'cristobal.espinoza', 27),(28, 'francisca.oliva', 28),(29, 'vicente.valdes', 29),(30, 'antonia.molina', 30),
(31, 'martin.castillo', 31),(32, 'isidora.silva', 32),(33, 'benjamin.henriquez', 33),(34, 'josefina.vera', 34),(35, 'lucas.cortes', 35),
(36, 'agustina.navarro', 36),(37, 'gabriel.carrasco', 37),(38, 'amanda.fuentes', 38),(39, 'david.guzman', 39),(40, 'sofia.pizarro', 40),
(41, 'emilio.avila', 41),(42, 'julieta.leon', 42),(43, 'maximiliano.sandoval', 43),(44, 'renata.rivera', 44),(45, 'tomas.espinosa', 45),
(46, 'amparo.miranda', 46),(47, 'leandro.santana', 47),(48, 'valeria.salazar', 48),(49, 'agustin.venegas', 49),(50, 'maite.bravo', 50);
GO

/* =========================================================
   SISTEMA OPERATIVO
   ========================================================= */
INSERT INTO Sistema_Operativo (ID_SO, Nombre_sistema_Operativo, Licencia_Sistema_OP) VALUES
(1, 'Windows 10 Pro', 'W10-123'),(2, 'Windows 11 Home', 'W11-456'),(3, 'Ubuntu 22.04', NULL),(4, 'macOS Ventura', 'MAC-001'),(5, 'Windows 10 Home', 'W10-777'),
(6, 'Fedora 38', NULL),(7, 'Windows 11 Pro', 'W11-888'),(8, 'Debian 12', NULL),(9, 'Windows Server 2022', 'WS-2022'),(10, 'Linux Mint 21', NULL),
(11, 'Windows 10 LTSC', 'W10-LTSC'),(12, 'CentOS 9', NULL),(13, 'Manjaro 22', NULL),(14, 'Windows 11 Education', 'W11-EDU'),(15, 'Ubuntu Server 22', NULL),
(16, 'Windows Server 2019', 'WS-2019'),(17, 'macOS Monterey', 'MAC-002'),(18, 'Pop!_OS 22', NULL),(19, 'Windows 11 IoT', 'W11-IOT'),(20, 'Rocky Linux 9', NULL),
(21, 'AlmaLinux 9', NULL),(22, 'Kali Linux', NULL),(23, 'Parrot OS', NULL),(24, 'Arch Linux', NULL),(25, 'Zorin OS', NULL),
(26, 'Elementary OS', NULL),(27, 'MX Linux', NULL),(28, 'EndeavourOS', NULL),(29, 'Garuda Linux', NULL),(30, 'FreeBSD 13', NULL),
(31, 'OpenSUSE Leap', NULL),(32, 'RHEL 9', 'RHEL-001'),(33, 'Oracle Linux', NULL),(34, 'ClearOS', NULL),(35, 'TrueNAS Core', NULL),
(36, 'Proxmox VE', NULL),(37, 'VMware ESXi', 'VMW-001'),(38, 'XCP-ng', NULL),(39, 'NixOS', NULL),(40, 'Void Linux', NULL),
(41, 'Gentoo Linux', NULL),(42, 'Slackware 15', NULL),(43, 'Chrome OS', NULL),(44, 'Android 13', NULL),(45, 'iOS 17', NULL),
(46, 'Windows 10 Enterprise', 'W10-ENT'),(47, 'Windows 11 Enterprise', 'W11-ENT'),(48, 'macOS Sonoma', 'MAC-003'),(49, 'Fedora 39', NULL),(50, 'Ubuntu 23.10', NULL);
GO

/* =========================================================
   PROCESADOR
   ========================================================= */
INSERT INTO Procesador (cod_Procesador, Modelo_Procesador, Velocidad_Procesador) VALUES
(1, 'Intel i5-11400', 2.60),(2, 'Intel i7-10700', 2.90),(3, 'Ryzen 5 5600X', 3.70),(4, 'Ryzen 7 5800H', 3.20),(5, 'Intel i3-10100', 3.60),
(6, 'Intel i9-10900K', 3.70),(7, 'Ryzen 9 5900X', 3.70),(8, 'Intel i5-1135G7', 2.40),(9, 'Ryzen 3 4300U', 2.70),(10, 'Intel i7-1165G7', 2.80),
(11, 'Ryzen 5 3500U', 2.10),(12, 'Intel i5-10210U', 1.60),(13, 'Ryzen 7 4800H', 2.90),(14, 'Intel i7-11800H', 2.30),(15, 'Ryzen 5 4600H', 3.00),
(16, 'Intel i7-12700K', 3.60),(17, 'Ryzen 9 7950X', 4.50),(18, 'Intel i9-13900K', 3.00),(19, 'Apple M1', 3.20),(20, 'Apple M2', 3.50),
(21, 'Intel i5-12400', 2.50),(22, 'Ryzen 7 5700X', 3.40),(23, 'Intel i3-12100', 3.30),(24, 'Ryzen 5 7600X', 4.70),(25, 'Intel i7-13700K', 3.40),
(26, 'Ryzen 7 7700X', 4.50),(27, 'Intel i9-12900K', 3.20),(28, 'Ryzen 9 7900X', 4.70),(29, 'Intel Xeon E-2288G', 3.70),(30, 'AMD EPYC 7313', 3.00),
(31, 'Intel Celeron G5900', 3.40),(32, 'Intel Pentium G6400', 4.00),(33, 'Qualcomm 8cx', 3.00),(34, 'Apple M1 Pro', 3.20),(35, 'Apple M2 Pro', 3.50),
(36, 'Intel i5-12600K', 3.70),(37, 'Ryzen 5 4500', 3.60),(38, 'Intel i5-9400', 2.90),(39, 'Intel i7-9700K', 3.60),(40, 'Ryzen 3 3200G', 3.60),
(41, 'Ryzen 5 3400G', 3.70),(42, 'Intel i7-11600H', 2.50),(43, 'Ryzen 7 6800H', 3.20),(44, 'Intel i9-12900H', 2.50),(45, 'Ryzen 9 6900HX', 3.30),
(46, 'Intel i5-12500H', 2.50),(47, 'Ryzen 5 6600H', 3.30),(48, 'Intel i7-12800H', 2.40),(49, 'Ryzen 7 5800X3D', 3.40),(50, 'Intel i9-14900K', 3.20);
GO

/* =========================================================
   GPU
   ========================================================= */
INSERT INTO GPU (ID_GPU, Modelo_GPU, Memoria_GPU) VALUES
(1, 'RTX 3060', 12),(2, 'GTX 1650', 4),(3, 'RTX 3080', 12),(4, 'RX 6800M', 16),(5, 'GTX 1050 Ti', 4),
(6, 'Intel UHD', 0),(7, 'RTX 3070', 8),(8, 'RX 5700', 8),(9, 'GT 1030', 2),(10, 'RTX 3090', 24),
(11, 'Intel Iris Xe', 0),(12, 'Vega 8', 2),(13, 'T1200', 4),(14, 'RTX 2060', 6),(15, 'RX 6600', 8),
(16, 'RTX 4060', 8),(17, 'RTX 4070', 12),(18, 'RTX 4080', 16),(19, 'RTX 4090', 24),(20, 'RX 6700 XT', 12),
(21, 'RX 6800', 16),(22, 'RX 6900 XT', 16),(23, 'RX 7600', 8),(24, 'RX 7700 XT', 12),(25, 'RX 7800 XT', 16),
(26, 'Intel Arc A380', 6),(27, 'Intel Arc A750', 8),(28, 'Intel Arc A770', 16),(29, 'NVIDIA T400', 2),(30, 'NVIDIA T600', 4),
(31, 'NVIDIA T1000', 8),(32, 'Quadro P400', 2),(33, 'Quadro P1000', 4),(34, 'RTX A2000', 12),(35, 'RTX A4000', 16),
(36, 'RTX A5000', 24),(37, 'RTX A6000', 48),(38, 'AMD Instinct MI100', 32),(39, 'AMD Instinct MI200', 64),(40, 'NVIDIA H100', 80),
(41, 'Apple M1 GPU', 8),(42, 'Apple M2 GPU', 10),(43, 'Apple M1 Max', 32),(44, 'Adreno 690', 4),(45, 'Mali-G78', 4),
(46, 'GTX 1660', 6),(47, 'RTX 2070', 8),(48, 'RX 5700 XT', 8),(49, 'RX 6500 XT', 4),(50, 'GT 710', 2);
GO

/* =========================================================
   ACCESO REMOTO
   ========================================================= */
INSERT INTO Acceso_Remoto (ID_Anydesk, Cod_Anydesk, Contra_Anydesk) VALUES
(1, 'ANY001', 'pass1'),(2, 'ANY002', 'pass2'),(3, 'ANY003', 'pass3'),(4, 'ANY004', 'pass4'),(5, 'ANY005', 'pass5'),
(6, 'ANY006', 'pass6'),(7, 'ANY007', 'pass7'),(8, 'ANY008', 'pass8'),(9, 'ANY009', 'pass9'),(10, 'ANY010', 'pass10'),
(11, 'ANY011', 'pass11'),(12, 'ANY012', 'pass12'),(13, 'ANY013', 'pass13'),(14, 'ANY014', 'pass14'),(15, 'ANY015', 'pass15'),
(16, 'ANY016', 'pass16'),(17, 'ANY017', 'pass17'),(18, 'ANY018', 'pass18'),(19, 'ANY019', 'pass19'),(20, 'ANY020', 'pass20'),
(21, 'ANY021', 'pass21'),(22, 'ANY022', 'pass22'),(23, 'ANY023', 'pass23'),(24, 'ANY024', 'pass24'),(25, 'ANY025', 'pass25'),
(26, 'ANY026', 'pass26'),(27, 'ANY027', 'pass27'),(28, 'ANY028', 'pass28'),(29, 'ANY029', 'pass29'),(30, 'ANY030', 'pass30'),
(31, 'ANY031', 'pass31'),(32, 'ANY032', 'pass32'),(33, 'ANY033', 'pass33'),(34, 'ANY034', 'pass34'),(35, 'ANY035', 'pass35'),
(36, 'ANY036', 'pass36'),(37, 'ANY037', 'pass37'),(38, 'ANY038', 'pass38'),(39, 'ANY039', 'pass39'),(40, 'ANY040', 'pass40'),
(41, 'ANY041', 'pass41'),(42, 'ANY042', 'pass42'),(43, 'ANY043', 'pass43'),(44, 'ANY044', 'pass44'),(45, 'ANY045', 'pass45'),
(46, 'ANY046', 'pass46'),(47, 'ANY047', 'pass47'),(48, 'ANY048', 'pass48'),(49, 'ANY049', 'pass49'),(50, 'ANY050', 'pass50');
GO

/* =========================================================
   MOUSE
   ========================================================= */
INSERT INTO Mouse (N_serie_Mouse, Marca_Mouse) VALUES
('M001', 'Logitech'),('M002', 'HP'),('M003', 'Dell'),('M004', 'Microsoft'),('M005', 'Razer'),
('M006', 'Genius'),('M007', 'Logitech'),('M008', 'HP'),('M009', 'Dell'),('M010', 'Microsoft'),
('M011', 'Razer'),('M012', 'Genius'),('M013', 'Logitech'),('M014', 'HP'),('M015', 'Dell'),
('M016', 'Corsair'),('M017', 'SteelSeries'),('M018', 'Asus'),('M019', 'Acer'),('M020', 'Lenovo'),
('M021', 'Logitech'),('M022', 'HP'),('M023', 'Dell'),('M024', 'Microsoft'),('M025', 'Razer'),
('M026', 'Genius'),('M027', 'Logitech'),('M028', 'HP'),('M029', 'Dell'),('M030', 'Microsoft'),
('M031', 'Razer'),('M032', 'Genius'),('M033', 'Corsair'),('M034', 'SteelSeries'),('M035', 'Asus'),
('M036', 'Acer'),('M037', 'Lenovo'),('M038', 'Logitech'),('M039', 'HP'),('M040', 'Dell'),
('M041', 'Microsoft'),('M042', 'Razer'),('M043', 'Genius'),('M044', 'Corsair'),('M045', 'SteelSeries'),
('M046', 'Asus'),('M047', 'Acer'),('M048', 'Lenovo'),('M049', 'Logitech'),('M050', 'HP');
GO

/* =========================================================
   TECLADO
   ========================================================= */
INSERT INTO Teclado (N_serie_teclado, Marca_Teclado) VALUES
('T001', 'Logitech'),('T002', 'HP'),('T003', 'Dell'),('T004', 'Microsoft'),('T005', 'Razer'),
('T006', 'Genius'),('T007', 'Logitech'),('T008', 'HP'),('T009', 'Dell'),('T010', 'Microsoft'),
('T011', 'Razer'),('T012', 'Genius'),('T013', 'Logitech'),('T014', 'HP'),('T015', 'Dell'),
('T016', 'Corsair'),('T017', 'SteelSeries'),('T018', 'Asus'),('T019', 'Acer'),('T020', 'Lenovo'),
('T021', 'Logitech'),('T022', 'HP'),('T023', 'Dell'),('T024', 'Microsoft'),('T025', 'Razer'),
('T026', 'Genius'),('T027', 'Logitech'),('T028', 'HP'),('T029', 'Dell'),('T030', 'Microsoft'),
('T031', 'Razer'),('T032', 'Genius'),('T033', 'Corsair'),('T034', 'SteelSeries'),('T035', 'Asus'),
('T036', 'Acer'),('T037', 'Lenovo'),('T038', 'Logitech'),('T039', 'HP'),('T040', 'Dell'),
('T041', 'Microsoft'),('T042', 'Razer'),('T043', 'Genius'),('T044', 'Corsair'),('T045', 'SteelSeries'),
('T046', 'Asus'),('T047', 'Acer'),('T048', 'Lenovo'),('T049', 'Logitech'),('T050', 'HP');
GO

/* =========================================================
   MONITOR
   ========================================================= */
INSERT INTO Monitor (N_serie_Monitor, Modelo_Monitor, Marca_Monitor) VALUES
('MON001', '24MP400', 'LG'),('MON002', 'S24R350', 'Samsung'),('MON003', 'P2419H', 'Dell'),('MON004', 'V24i', 'HP'),('MON005', 'SB220Q', 'Acer'),
('MON006', '27GL850', 'LG'),('MON007', 'T35F', 'Samsung'),('MON008', 'U2720Q', 'Dell'),('MON009', 'E243', 'HP'),('MON010', 'KG241Q', 'Acer'),
('MON011', '32UN880', 'LG'),('MON012', 'C24F390', 'Samsung'),('MON013', 'S2721QS', 'Dell'),('MON014', 'X24ih', 'HP'),('MON015', 'ED320QR', 'Acer'),
('MON016', '27GN800', 'LG'),('MON017', 'Odyssey G7', 'Samsung'),('MON018', 'UltraSharp U3219Q', 'Dell'),('MON019', 'Omen 27i', 'HP'),('MON020', 'Predator X27', 'Acer'),
('MON021', '34WN80C', 'LG'),('MON022', 'CRG9', 'Samsung'),('MON023', 'Alienware 25', 'Dell'),('MON024', 'E27u G4', 'HP'),('MON025', 'Nitro VG271U', 'Acer'),
('MON026', '27GP950', 'LG'),('MON027', 'C27G2', 'Samsung'),('MON028', 'G2724D', 'Dell'),('MON029', 'X27q', 'HP'),('MON030', 'CB282K', 'Acer'),
('MON031', 'ProArt PA278QV', 'Asus'),('MON032', 'ROG Swift', 'Asus'),('MON033', 'TUF Gaming', 'Asus'),('MON034', 'VG248QG', 'Asus'),('MON035', 'VP249QGR', 'Asus'),
('MON036', 'G24C', 'MSI'),('MON037', 'MAG274', 'MSI'),('MON038', 'Optix G24', 'MSI'),('MON039', 'Summit MS321', 'MSI'),('MON040', 'G24F', 'Gigabyte'),
('MON041', 'M27Q', 'Gigabyte'),('MON042', 'Aorus FI27Q', 'Gigabyte'),('MON043', 'GW2780', 'BenQ'),('MON044', 'PD3220U', 'BenQ'),('MON045', 'EX2780Q', 'BenQ'),
('MON046', 'VA2432', 'ViewSonic'),('MON047', 'VX2758', 'ViewSonic'),('MON048', 'XG270QG', 'ViewSonic'),('MON049', '243V7', 'Philips'),('MON050', '276E8', 'Philips');
GO

/* =========================================================
   PARLANTE
   ========================================================= */
INSERT INTO Parlante (N_serie_Parlante, Marca_Parlante) VALUES
('P001', 'Genius'),('P002', 'Logitech'),('P003', 'Creative'),('P004', 'HP'),('P005', 'Dell'),
('P006', 'Genius'),('P007', 'Logitech'),('P008', 'Creative'),('P009', 'HP'),('P010', 'Dell'),
('P011', 'Genius'),('P012', 'Logitech'),('P013', 'Creative'),('P014', 'HP'),('P015', 'Dell'),
('P016', 'JBL'),('P017', 'Bose'),('P018', 'Sony'),('P019', 'Edifier'),('P020', 'Altec Lansing'),
('P021', 'Razer'),('P022', 'Corsair'),('P023', 'LG'),('P024', 'Panasonic'),('P025', 'Microlab'),
('P026', 'Genius'),('P027', 'Logitech'),('P028', 'Creative'),('P029', 'HP'),('P030', 'Dell'),
('P031', 'JBL'),('P032', 'Bose'),('P033', 'Sony'),('P034', 'Edifier'),('P035', 'Altec Lansing'),
('P036', 'Razer'),('P037', 'Corsair'),('P038', 'LG'),('P039', 'Panasonic'),('P040', 'Microlab'),
('P041', 'Genius'),('P042', 'Logitech'),('P043', 'Creative'),('P044', 'HP'),('P045', 'Dell'),
('P046', 'JBL'),('P047', 'Bose'),('P048', 'Sony'),('P049', 'Edifier'),('P050', 'Altec Lansing');
GO

/* =========================================================
   SOFTWARE
   ========================================================= */
INSERT INTO Software (ID_software, Categoria, nombre_software) VALUES
(1, 'Ofimatica', 'Office 365'),(2, 'Antivirus', 'Norton'),(3, 'Desarrollo', 'VS Code'),(4, 'Navegadores', 'Chrome'),(5, 'Diseño', 'Photoshop'),
(6, 'Otro', 'Slack'),(7, 'Ofimatica', 'LibreOffice'),(8, 'Antivirus', 'McAfee'),(9, 'Desarrollo', 'PyCharm'),(10, 'Navegadores', 'Firefox'),
(11, 'Diseño', 'AutoCAD'),(12, 'Otro', 'Zoom'),(13, 'Otro', 'Spotify'),(14, 'Otro', 'VMware'),(15, 'Desarrollo', 'Git'),
(16, 'Antivirus', 'Kaspersky'),(17, 'Antivirus', 'Bitdefender'),(18, 'Antivirus', 'Avast'),(19, 'Navegadores', 'Edge'),(20, 'Navegadores', 'Opera'),
(21, 'Navegadores', 'Brave'),(22, 'Desarrollo', 'IntelliJ IDEA'),(23, 'Desarrollo', 'Eclipse'),(24, 'Desarrollo', 'Android Studio'),(25, 'Ofimatica', 'WPS Office'),
(26, 'Diseño', 'Illustrator'),(27, 'Diseño', 'CorelDRAW'),(28, 'Diseño', 'Figma'),(29, 'Otro', 'Discord'),(30, 'Otro', 'Teams'),
(31, 'Otro', 'Skype'),(32, 'Otro', 'WhatsApp'),(33, 'Multimedia', 'VLC'),(34, 'Multimedia', 'Spotify'),(35, 'Multimedia', 'WinRAR'),
(36, 'Multimedia', '7-Zip'),(37, 'Multimedia', 'Adobe Acrobat'),(38, 'Multimedia', 'Premiere Pro'),(39, 'Multimedia', 'After Effects'),(40, 'Multimedia', 'DaVinci Resolve'),
(41, 'BaseDatos', 'SQL Server'),(42, 'BaseDatos', 'MySQL'),(43, 'BaseDatos', 'PostgreSQL'),(44, 'BaseDatos', 'Oracle'),(45, 'BaseDatos', 'MongoDB'),
(46, 'Virtualizacion', 'Docker'),(47, 'Virtualizacion', 'Kubernetes'),(48, 'Virtualizacion', 'VirtualBox'),(49, 'Utilidades', 'CCleaner'),(50, 'Utilidades', 'Malwarebytes');
GO

/* =========================================================
   EQUIPO (Líneas reparadas y mapeadas a las llaves foráneas válidas)
   ========================================================= */
INSERT INTO Equipo (N_serie, Marca_Modelo, tipo_Hardware, Ram_GB, Unidad_CD, Regulador, Observacion, Estado, ID_SO, ID_GPU, cod_Procesador, ID_Anydesk, N_serie_Mouse, N_serie_teclado, N_serie_Monitor, N_serie_Parlante) VALUES
('SN001', 'Dell OptiPlex', 'Escritorio', 16, 1, 1, 'Asignado a Contabilidad', 'OK', 1, 1, 1, 1, 'M001', 'T001', 'MON001', 'P001'),
('SN002', 'HP EliteBook', 'Laptop', 8, 0, 1, 'Portatil de Sistemas', 'OK', 2, 2, 2, 2, 'M002', 'T002', 'MON002', NULL),
('SN003', 'Lenovo ThinkPad', 'Laptop', 16, 0, 1, 'Uso en RRHH', 'OK', 3, 3, 3, 3, 'M003', 'T003', 'MON003', 'P003'),
('SN004', 'Asus ROG', 'Escritorio', 32, 1, 1, 'Estacion de Ventas', 'OK', 4, 4, 4, 4, 'M004', 'T004', 'MON004', 'P004'),
('SN005', 'Acer Aspire', 'Laptop', 8, 1, 0, 'Asignado a Logistica', 'OK', 5, 5, 5, 5, 'M005', 'T005', 'MON005', NULL),
('SN006', 'Dell Latitude', 'Laptop', 16, 0, 1, 'Equipo de Marketing', 'OK', 6, 6, 6, 6, 'M006', 'T006', 'MON006', 'P006'),
('SN007', 'HP ProBook', 'Laptop', 8, 0, 1, 'Uso en Direccion', 'OK', 7, 7, 7, 7, 'M007', 'T007', 'MON007', NULL),
('SN008', 'Lenovo IdeaCentre', 'Escritorio', 16, 1, 1, 'Computadora de Almacen', 'OK', 8, 8, 8, 8, 'M008', 'T008', 'MON008', 'P008'),
('SN009', 'MacBook Pro', 'Laptop', 16, 0, 1, 'Equipo de Finanzas', 'OK', 9, 9, 9, 9, 'M009', 'T009', 'MON009', NULL),
('SN010', 'MSI Modern', 'Laptop', 8, 0, 0, 'Soporte Tecnico', 'OK', 10, 10, 10, 10, 'M010', 'T010', 'MON010', 'P010'),
('SN011', 'Dell XPS', 'Laptop', 16, 0, 1, 'Planta de Produccion', 'OK', 11, 11, 11, 11, 'M011', 'T011', 'MON011', NULL),
('SN012', 'HP Pavilion', 'Laptop', 8, 1, 1, 'Control de Calidad', 'OK', 12, 12, 12, 12, 'M012', 'T012', 'MON012', 'P012'),
('SN013', 'Lenovo Legion', 'Escritorio', 32, 1, 1, 'Oficina de Tesoreria', 'OK', 13, 13, 13, 13, 'M013', 'T013', 'MON013', NULL),
('SN014', 'Asus VivoBook', 'Laptop', 8, 0, 0, 'Asesoría Legal', 'OK', 14, 14, 14, 14, 'M014', 'T014', 'MON014', 'P014'),
('SN015', 'Acer Predator', 'Escritorio', 32, 1, 1, 'Area de Compras', 'OK', 15, 15, 15, 15, 'M015', 'T015', 'MON015', 'P015'),
('SN016', 'Gigabyte Aorus', 'Escritorio', 32, 1, 1, 'Oficina I+D', 'OK', 16, 16, 16, 16, 'M016', 'T016', 'MON016', 'P016');
GO
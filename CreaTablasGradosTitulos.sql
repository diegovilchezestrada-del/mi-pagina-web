USE GradosTitulos;
GO

-- ============================================================
-- 2. CREAR ESQUEMAS
-- ============================================================
CREATE SCHEMA Catalogo;   -- Tablas de parámetros y catálogos
GO
CREATE SCHEMA Academico;  -- Entidades académicas principales
GO
CREATE SCHEMA Tramite;    -- Proceso administrativo
GO
CREATE SCHEMA Evaluacion; -- Evaluaciones y sustentación
GO
CREATE SCHEMA Documento;  -- Resoluciones, diplomas y documentos
GO

-- ============================================================
USE GradosTitulos;
GO
-- ============================================================
-- 3. TABLAS DE CATÁLOGO
-- ============================================================

-- ------------------------------------------------------------
-- T01: TIPO_TRAMITE
-- Catálogo de tipos de trámite disponibles
-- ------------------------------------------------------------
CREATE TABLE Catalogo.TipoTramite (
    IdTipoTramite       TINYINT         NOT NULL,
    Descripcion         VARCHAR(60)     NOT NULL,
    RequiereTesis       BIT             NOT NULL DEFAULT 0,
    RequiereSuficiencia BIT             NOT NULL DEFAULT 0,
    RequiereBachiller   BIT             NOT NULL DEFAULT 0,  -- prerequisito obligatorio
    Activo              BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoTramite PRIMARY KEY (IdTipoTramite),
    CONSTRAINT UQ_TipoTramite_Descripcion UNIQUE (Descripcion)
);
GO

INSERT INTO Catalogo.TipoTramite VALUES
(1, 'BACHILLER',                   0, 0, 0, 1),
(2, 'TITULO_TESIS_INDIVIDUAL',     1, 0, 1, 1),
(3, 'TITULO_TESIS_GRUPAL',         1, 0, 1, 1),
(4, 'TITULO_SUFICIENCIA_PROF',     0, 1, 1, 1);
GO

-- ------------------------------------------------------------
-- T02: ESTADO_TRAMITE
-- Catálogo de estados del flujo administrativo
-- ------------------------------------------------------------
CREATE TABLE Catalogo.EstadoTramite (
    IdEstadoTramite TINYINT         NOT NULL,
    Descripcion     VARCHAR(40)     NOT NULL,
    EsTerminal      BIT             NOT NULL DEFAULT 0,  -- estado final del flujo
    CONSTRAINT PK_EstadoTramite PRIMARY KEY (IdEstadoTramite),
    CONSTRAINT UQ_EstadoTramite_Descripcion UNIQUE (Descripcion)
);
GO

INSERT INTO Catalogo.EstadoTramite VALUES
(1,  'INICIADO',         0),
(2,  'EN_VERIFICACION',  0),
(3,  'EN_PROCESO',       0),
(4,  'OBSERVADO',        0),
(5,  'APROBADO',         1),
(6,  'IMPROCEDENTE',     1),
(7,  'ARCHIVADO',        1),
(8,  'SUSPENDIDO',       0);
GO

-- ------------------------------------------------------------
-- T03: LINEA_INVESTIGACION
-- Líneas de investigación institucionales aprobadas
-- ------------------------------------------------------------
CREATE TABLE Catalogo.LineaInvestigacion (
    IdLinea              SMALLINT        NOT NULL IDENTITY(1,1),
    NombreLinea          VARCHAR(200)    NOT NULL,
    ResolucionAprobacion VARCHAR(40)     NULL,    -- Ej: Res. 1069-2019-CU-VRINV
    FechaAprobacion      DATE            NULL,
    Activo               BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_LineaInvestigacion PRIMARY KEY (IdLinea),
    CONSTRAINT UQ_LineaInvestigacion_Nombre UNIQUE (NombreLinea)
);
GO

-- ============================================================
-- 4. TABLAS DE ESTRUCTURA ACADÉMICA
-- ============================================================

-- ------------------------------------------------------------
-- T04: FACULTAD
-- ------------------------------------------------------------
CREATE TABLE Academico.Facultad (
    IdFacultad     TINYINT         NOT NULL IDENTITY(1,1),
    NombreFacultad VARCHAR(100)    NOT NULL,
    NombreDecano   VARCHAR(150)    NULL,
    Activo         BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_Facultad PRIMARY KEY (IdFacultad),
    CONSTRAINT UQ_Facultad_Nombre UNIQUE (NombreFacultad)
);
GO

INSERT INTO Academico.Facultad (NombreFacultad) VALUES
('Ciencias Administrativas y Contables'),
('Derecho y Ciencias Políticas'),
('Ingeniería'),
('Ciencias de la Salud'),
('Educación y Ciencias Humanas'),
('Medicina Humana');
GO

-- ------------------------------------------------------------
-- T05: PROGRAMA_ESTUDIOS
-- ------------------------------------------------------------
CREATE TABLE Academico.ProgramaEstudios (
    IdPrograma      SMALLINT        NOT NULL IDENTITY(1,1),
    IdFacultad      TINYINT         NOT NULL,
    NombrePrograma  VARCHAR(150)    NOT NULL,
    NumSemestres    TINYINT         NOT NULL,  -- 10, 12 o 14
    Modalidad       VARCHAR(15)     NOT NULL,  -- PRESENCIAL, SEMIPRESENCIAL
    Activo          BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_ProgramaEstudios PRIMARY KEY (IdPrograma),
    CONSTRAINT FK_Programa_Facultad
        FOREIGN KEY (IdFacultad) REFERENCES Academico.Facultad(IdFacultad),
    CONSTRAINT CHK_Programa_Semestres
        CHECK (NumSemestres IN (10, 12, 14)),
    CONSTRAINT CHK_Programa_Modalidad
        CHECK (Modalidad IN ('PRESENCIAL', 'SEMIPRESENCIAL')),
    CONSTRAINT UQ_Programa_Nombre_Modalidad
        UNIQUE (NombrePrograma, Modalidad)
);
GO

-- ------------------------------------------------------------
-- T06: GRADO_TITULO_CATALOGO
-- Denominaciones oficiales de grado y título por programa
-- ------------------------------------------------------------
CREATE TABLE Academico.GradoTituloCatalogo (
    IdGradoTitulo       SMALLINT        NOT NULL IDENTITY(1,1),
    IdPrograma          SMALLINT        NOT NULL,
    DenominacionGrado   VARCHAR(150)    NOT NULL,
    DenominacionTitulo  VARCHAR(150)    NOT NULL,
    Activo              BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_GradoTituloCatalogo PRIMARY KEY (IdGradoTitulo),
    CONSTRAINT FK_GradoTitulo_Programa
        FOREIGN KEY (IdPrograma) REFERENCES Academico.ProgramaEstudios(IdPrograma)
);
GO

-- ============================================================
-- 5. TABLAS DE PERSONAS Y ROLES
-- ============================================================

-- ------------------------------------------------------------
-- T07: PERSONA
-- Base común para estudiantes y docentes
-- ------------------------------------------------------------
CREATE TABLE Academico.Persona (
    IdPersona       INT             NOT NULL IDENTITY(1,1),
    DNI             CHAR(8)         NOT NULL,
    Nombres         VARCHAR(80)     NOT NULL,
    ApellidoPaterno VARCHAR(60)     NOT NULL,
    ApellidoMaterno VARCHAR(60)     NULL,
    Correo          VARCHAR(120)    NULL,
    Telefono        VARCHAR(15)     NULL,
    TipoPersona     VARCHAR(15)     NOT NULL,  -- ESTUDIANTE, DOCENTE
    FechaRegistro   DATETIME2       NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT PK_Persona PRIMARY KEY (IdPersona),
    CONSTRAINT UQ_Persona_DNI UNIQUE (DNI),
    CONSTRAINT CHK_Persona_DNI CHECK (DNI LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT CHK_Persona_Tipo CHECK (TipoPersona IN ('ESTUDIANTE', 'DOCENTE'))
);
GO

-- ------------------------------------------------------------
-- T08: DOCENTE
-- Especialización de Persona para asesores y jurados
-- ------------------------------------------------------------
CREATE TABLE Academico.Docente (
    IdDocente       INT             NOT NULL IDENTITY(1,1),
    IdPersona       INT             NOT NULL,
    GradoAcademico  VARCHAR(10)     NOT NULL,  -- MAESTRO, DOCTOR
    CodigoORCID     VARCHAR(25)     NULL,
    TipoContrato    VARCHAR(12)     NOT NULL,  -- ORDINARIO, CONTRATADO
    IdFacultad      TINYINT         NOT NULL,
    EstadoActivo    BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_Docente PRIMARY KEY (IdDocente),
    CONSTRAINT UQ_Docente_Persona UNIQUE (IdPersona),
    CONSTRAINT FK_Docente_Persona
        FOREIGN KEY (IdPersona) REFERENCES Academico.Persona(IdPersona),
    CONSTRAINT FK_Docente_Facultad
        FOREIGN KEY (IdFacultad) REFERENCES Academico.Facultad(IdFacultad),
    CONSTRAINT CHK_Docente_Grado
        CHECK (GradoAcademico IN ('MAESTRO', 'DOCTOR')),
    CONSTRAINT CHK_Docente_Contrato
        CHECK (TipoContrato IN ('ORDINARIO', 'CONTRATADO'))
);
GO

-- ============================================================
-- 6. TABLAS DE COORDINACIÓN
-- ============================================================

-- ------------------------------------------------------------
-- T09: COORDINACION_GT
-- Coordinación de Grados y Títulos por facultad
-- ------------------------------------------------------------
CREATE TABLE Tramite.CoordinacionGT (
    IdCoordinacion      TINYINT         NOT NULL IDENTITY(1,1),
    IdFacultad          TINYINT         NOT NULL,
    NombreCoordinador   VARCHAR(150)    NULL,
    FechaCreacion       DATE            NULL,
    Activo              BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_CoordinacionGT PRIMARY KEY (IdCoordinacion),
    CONSTRAINT FK_CoordGT_Facultad
        FOREIGN KEY (IdFacultad) REFERENCES Academico.Facultad(IdFacultad)
);
GO

-- ============================================================
-- 7. TABLAS DEL PROCESO DE MATRÍCULA Y TRÁMITE
-- ============================================================

-- ------------------------------------------------------------
-- T10: MATRICULA
-- Vínculo estudiante-programa, condición de egresado
-- ------------------------------------------------------------
CREATE TABLE Academico.Matricula (
    IdMatricula             INT             NOT NULL IDENTITY(1,1),
    IdEstudiante            INT             NOT NULL,
    IdPrograma              SMALLINT        NOT NULL,
    FechaMatricula          DATE            NOT NULL,
    CreditosAprobados       SMALLINT        NULL,
    AsignaturasAprobadas    BIT             NOT NULL DEFAULT 0,
    PracticasCompletadas    BIT             NOT NULL DEFAULT 0,
    IdiomaAprobado          BIT             NOT NULL DEFAULT 0,
    ProyeccionSocial        BIT             NOT NULL DEFAULT 0,
    TieneDeuda              BIT             NOT NULL DEFAULT 0,
    FechaEgreso             DATE            NULL,
    CONSTRAINT PK_Matricula PRIMARY KEY (IdMatricula),
    CONSTRAINT FK_Matricula_Estudiante
        FOREIGN KEY (IdEstudiante) REFERENCES Academico.Persona(IdPersona),
    CONSTRAINT FK_Matricula_Programa
        FOREIGN KEY (IdPrograma) REFERENCES Academico.ProgramaEstudios(IdPrograma)
);
GO

-- ------------------------------------------------------------
-- T11: TRAMITE
-- Proceso administrativo principal
-- ------------------------------------------------------------
CREATE TABLE Tramite.Tramite (
    IdTramite       INT             NOT NULL IDENTITY(1,1),
    IdMatricula     INT             NOT NULL,
    IdTipoTramite   TINYINT         NOT NULL,
    IdEstadoTramite TINYINT         NOT NULL DEFAULT 1,
    IdCoordinacion  TINYINT         NOT NULL,
    FechaInicio     DATE            NOT NULL DEFAULT CAST(SYSDATETIME() AS DATE),
    FechaUltMod     DATETIME2       NOT NULL DEFAULT SYSDATETIME(),
    Observaciones   VARCHAR(500)    NULL,
    CONSTRAINT PK_Tramite PRIMARY KEY (IdTramite),
    CONSTRAINT FK_Tramite_Matricula
        FOREIGN KEY (IdMatricula) REFERENCES Academico.Matricula(IdMatricula),
    CONSTRAINT FK_Tramite_TipoTramite
        FOREIGN KEY (IdTipoTramite) REFERENCES Catalogo.TipoTramite(IdTipoTramite),
    CONSTRAINT FK_Tramite_EstadoTramite
        FOREIGN KEY (IdEstadoTramite) REFERENCES Catalogo.EstadoTramite(IdEstadoTramite),
    CONSTRAINT FK_Tramite_Coordinacion
        FOREIGN KEY (IdCoordinacion) REFERENCES Tramite.CoordinacionGT(IdCoordinacion)
);
GO

-- ------------------------------------------------------------
-- T12: PAGO
-- Pagos asociados al trámite (Art. 23°, 49°)
-- ------------------------------------------------------------
CREATE TABLE Tramite.Pago (
    IdPago      INT             NOT NULL IDENTITY(1,1),
    IdTramite   INT             NOT NULL,
    TipoPago    VARCHAR(25)     NOT NULL,
    -- BACHILLER, TESIS_5PCT, TESIS_40PCT, TESIS_TOTAL,
    -- AMPLIACION, CAMBIO_TITULO, POSTERGACION, NUEVO_PLAN
    Monto       DECIMAL(10,2)   NOT NULL,
    Porcentaje  DECIMAL(5,2)    NULL,   -- 5.00, 40.00, 100.00
    FechaPago   DATE            NOT NULL,
    NroRecibo   VARCHAR(30)     NULL,
    CONSTRAINT PK_Pago PRIMARY KEY (IdPago),
    CONSTRAINT FK_Pago_Tramite
        FOREIGN KEY (IdTramite) REFERENCES Tramite.Tramite(IdTramite),
    CONSTRAINT CHK_Pago_Monto CHECK (Monto > 0),
    CONSTRAINT CHK_Pago_Tipo CHECK (TipoPago IN (
        'BACHILLER', 'TESIS_5PCT', 'TESIS_40PCT', 'TESIS_TOTAL',
        'AMPLIACION', 'CAMBIO_TITULO', 'POSTERGACION', 'NUEVO_PLAN',
        'SUFICIENCIA_40PCT', 'SUFICIENCIA_TOTAL'
    ))
);
GO

-- ------------------------------------------------------------
-- T13: FOTOGRAFIA
-- Datos de la fotografía requerida en el trámite (Art. 15°)
-- ------------------------------------------------------------
CREATE TABLE Tramite.Fotografia (
    IdFoto          INT             NOT NULL IDENTITY(1,1),
    IdTramite       INT             NOT NULL,
    Formato         VARCHAR(5)      NOT NULL DEFAULT 'JPG',
    TamanioKB       SMALLINT        NOT NULL,   -- máx 70 KB
    ResolucionPPP   SMALLINT        NOT NULL,   -- máx 300 ppp
    Dimensiones     VARCHAR(15)     NOT NULL DEFAULT '35x43mm',
    RutaArchivo     VARCHAR(300)    NULL,
    FechaCarga      DATETIME2       NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT PK_Fotografia PRIMARY KEY (IdFoto),
    CONSTRAINT FK_Foto_Tramite
        FOREIGN KEY (IdTramite) REFERENCES Tramite.Tramite(IdTramite),
    CONSTRAINT CHK_Foto_Formato CHECK (Formato IN ('JPG', 'JPEG')),
    CONSTRAINT CHK_Foto_Tamanio CHECK (TamanioKB BETWEEN 1 AND 70),
    CONSTRAINT CHK_Foto_Resolucion CHECK (ResolucionPPP BETWEEN 72 AND 300)
);
GO

-- ============================================================
-- 8. TABLAS DEL TRABAJO DE INVESTIGACIÓN
-- ============================================================

-- ------------------------------------------------------------
-- T14: TRABAJO_INVESTIGACION
-- Tesis o Trabajo de Suficiencia Profesional (Art. 31°, 47°)
-- ------------------------------------------------------------
CREATE TABLE Tramite.TrabajoInvestigacion (
    IdTrabajo           INT             NOT NULL IDENTITY(1,1),
    IdTramite           INT             NOT NULL,
    IdLinea             SMALLINT        NOT NULL,
    TipoTrabajo         VARCHAR(25)     NOT NULL,
    -- TESIS_CUANTITATIVA, TESIS_CUALITATIVA,
    -- TESIS_MIXTA, SUFICIENCIA_PROFESIONAL
    Titulo              NVARCHAR(400)   NOT NULL,
    FechaInicio         DATE            NOT NULL,
    FechaFin            DATE            NULL,
    ModalidadAutoria    VARCHAR(12)     NOT NULL DEFAULT 'INDIVIDUAL',
    -- INDIVIDUAL, GRUPAL (solo tesis, máx 2)
    PorcentajeSimilitud DECIMAL(5,2)    NULL,   -- resultado final antiplagio
    UrlRepositorio      VARCHAR(500)    NULL,
    FechaRegistro       DATETIME2       NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT PK_TrabajoInvestigacion PRIMARY KEY (IdTrabajo),
    CONSTRAINT FK_Trabajo_Tramite
        FOREIGN KEY (IdTramite) REFERENCES Tramite.Tramite(IdTramite),
    CONSTRAINT FK_Trabajo_Linea
        FOREIGN KEY (IdLinea) REFERENCES Catalogo.LineaInvestigacion(IdLinea),
    CONSTRAINT CHK_Trabajo_Tipo CHECK (TipoTrabajo IN (
        'TESIS_CUANTITATIVA', 'TESIS_CUALITATIVA',
        'TESIS_MIXTA', 'SUFICIENCIA_PROFESIONAL'
    )),
    CONSTRAINT CHK_Trabajo_Autoria
        CHECK (ModalidadAutoria IN ('INDIVIDUAL', 'GRUPAL')),
    CONSTRAINT CHK_Trabajo_Similitud
        CHECK (PorcentajeSimilitud IS NULL OR PorcentajeSimilitud BETWEEN 0 AND 100)
);
GO

-- ------------------------------------------------------------
-- T15: PLAN_TESIS
-- Plan metodológico previo al desarrollo de la tesis (Art. 20°)
-- ------------------------------------------------------------
CREATE TABLE Tramite.PlanTesis (
    IdPlan          INT             NOT NULL IDENTITY(1,1),
    IdTrabajo       INT             NOT NULL,
    TituloPlan      NVARCHAR(400)   NOT NULL,
    FechaAprobacion DATE            NULL,
    FechaInicio     DATE            NOT NULL,
    FechaFin        DATE            NOT NULL,
    EstadoPlan      VARCHAR(15)     NOT NULL DEFAULT 'VIGENTE',
    -- VIGENTE, AMPLIADO, SIN_EFECTO
    CONSTRAINT PK_PlanTesis PRIMARY KEY (IdPlan),
    CONSTRAINT FK_Plan_Trabajo
        FOREIGN KEY (IdTrabajo) REFERENCES Tramite.TrabajoInvestigacion(IdTrabajo),
    CONSTRAINT CHK_Plan_Estado
        CHECK (EstadoPlan IN ('VIGENTE', 'AMPLIADO', 'SIN_EFECTO')),
    CONSTRAINT CHK_Plan_Fechas
        CHECK (FechaFin >= FechaInicio)
);
GO

-- ------------------------------------------------------------
-- T16: DESIGNACION_ASESOR
-- Asignación del asesor al trabajo (Art. 24°, 66°)
-- ------------------------------------------------------------
CREATE TABLE Tramite.DesignacionAsesor (
    IdDesignacion   INT             NOT NULL IDENTITY(1,1),
    IdTrabajo       INT             NOT NULL,
    IdDocente       INT             NOT NULL,
    FechaDesignacion DATE           NOT NULL DEFAULT CAST(SYSDATETIME() AS DATE),
    NroResolucion   VARCHAR(40)     NOT NULL,
    Estado          VARCHAR(12)     NOT NULL DEFAULT 'ACTIVO',
    -- ACTIVO, SUSTITUIDO, RENUNCIADO
    MotivoRetiro    VARCHAR(200)    NULL,
    CONSTRAINT PK_DesignacionAsesor PRIMARY KEY (IdDesignacion),
    CONSTRAINT FK_DesigAsesor_Trabajo
        FOREIGN KEY (IdTrabajo) REFERENCES Tramite.TrabajoInvestigacion(IdTrabajo),
    CONSTRAINT FK_DesigAsesor_Docente
        FOREIGN KEY (IdDocente) REFERENCES Academico.Docente(IdDocente),
    CONSTRAINT CHK_DesigAsesor_Estado
        CHECK (Estado IN ('ACTIVO', 'SUSTITUIDO', 'RENUNCIADO'))
);
GO

-- ------------------------------------------------------------
-- T17: DESIGNACION_JURADO
-- Asignación de jurados revisores/evaluadores (Art. 34°, 72°)
-- ------------------------------------------------------------
CREATE TABLE Tramite.DesignacionJurado (
    IdDesigJurado   INT             NOT NULL IDENTITY(1,1),
    IdTrabajo       INT             NOT NULL,
    IdDocente       INT             NOT NULL,
    NroResolucion   VARCHAR(40)     NOT NULL,
    RolJurado       VARCHAR(12)     NOT NULL,
    -- TITULAR_1, TITULAR_2, TITULAR_3, SUPLENTE
    Estado          VARCHAR(12)     NOT NULL DEFAULT 'DESIGNADO',
    -- DESIGNADO, REEMPLAZADO, INASISTENTE
    FechaDesignacion DATE           NOT NULL DEFAULT CAST(SYSDATETIME() AS DATE),
    CONSTRAINT PK_DesignacionJurado PRIMARY KEY (IdDesigJurado),
    CONSTRAINT FK_DesigJurado_Trabajo
        FOREIGN KEY (IdTrabajo) REFERENCES Tramite.TrabajoInvestigacion(IdTrabajo),
    CONSTRAINT FK_DesigJurado_Docente
        FOREIGN KEY (IdDocente) REFERENCES Academico.Docente(IdDocente),
    CONSTRAINT CHK_DesigJurado_Rol
        CHECK (RolJurado IN ('TITULAR_1', 'TITULAR_2', 'TITULAR_3', 'SUPLENTE')),
    CONSTRAINT CHK_DesigJurado_Estado
        CHECK (Estado IN ('DESIGNADO', 'REEMPLAZADO', 'INASISTENTE'))
);
GO

-- ------------------------------------------------------------
-- T18: EXPERIENCIA_LABORAL
-- Para modalidad suficiencia profesional (Art. 49° inc. c)
-- Mínimo 2 años acumulativos después del grado de bachiller
-- ------------------------------------------------------------
CREATE TABLE Tramite.ExperienciaLaboral (
    IdExperiencia       INT             NOT NULL IDENTITY(1,1),
    IdTramite           INT             NOT NULL,
    NombreEntidad       VARCHAR(200)    NOT NULL,
    TipoEntidad         VARCHAR(8)      NOT NULL,   -- PUBLICA, PRIVADA
    Cargo               VARCHAR(150)    NULL,
    FechaInicio         DATE            NOT NULL,
    FechaFin            DATE            NULL,       -- NULL si sigue activo
    AniosAcumulados     DECIMAL(4,2)    NULL,
    NroCertificadoTrab  VARCHAR(60)     NULL,
    TipoDocPago         VARCHAR(20)     NULL,
    -- BOLETA_PAGO, RECIBO_HONORARIOS
    CONSTRAINT PK_ExperienciaLaboral PRIMARY KEY (IdExperiencia),
    CONSTRAINT FK_ExpLaboral_Tramite
        FOREIGN KEY (IdTramite) REFERENCES Tramite.Tramite(IdTramite),
    CONSTRAINT CHK_ExpLaboral_TipoEntidad
        CHECK (TipoEntidad IN ('PUBLICA', 'PRIVADA')),
    CONSTRAINT CHK_ExpLaboral_Fechas
        CHECK (FechaFin IS NULL OR FechaFin >= FechaInicio),
    CONSTRAINT CHK_ExpLaboral_TipoDoc
        CHECK (TipoDocPago IS NULL OR TipoDocPago IN (
            'BOLETA_PAGO', 'RECIBO_HONORARIOS'
        ))
);
GO

-- ============================================================
-- 9. TABLAS DE EVALUACIÓN
-- ============================================================

-- ------------------------------------------------------------
-- T19: EVALUACION_TRABAJO
-- Evaluaciones formales del asesor y jurados (Anexos 3-7)
-- ------------------------------------------------------------
CREATE TABLE Evaluacion.EvaluacionTrabajo (
    IdEvaluacion        INT             NOT NULL IDENTITY(1,1),
    IdTrabajo           INT             NOT NULL,
    IdEvaluador         INT             NOT NULL,   -- FK → Docente
    TipoEvaluador       VARCHAR(8)      NOT NULL,   -- ASESOR, JURADO
    EtapaEvaluacion     VARCHAR(18)     NOT NULL,
    -- PLAN, INFORME_FINAL, SUSTENTACION
    PuntajeObtenido     DECIMAL(5,2)    NULL,
    Condicion           VARCHAR(20)     NULL,
    -- APROBADO, OBS_MENORES, OBS_MAYORES, DESAPROBADO
    FechaEvaluacion     DATE            NULL,
    Observaciones       NVARCHAR(2000)  NULL,
    CONSTRAINT PK_EvaluacionTrabajo PRIMARY KEY (IdEvaluacion),
    CONSTRAINT FK_Eval_Trabajo
        FOREIGN KEY (IdTrabajo) REFERENCES Tramite.TrabajoInvestigacion(IdTrabajo),
    CONSTRAINT FK_Eval_Docente
        FOREIGN KEY (IdEvaluador) REFERENCES Academico.Docente(IdDocente),
    CONSTRAINT CHK_Eval_TipoEval
        CHECK (TipoEvaluador IN ('ASESOR', 'JURADO')),
    CONSTRAINT CHK_Eval_Etapa
        CHECK (EtapaEvaluacion IN ('PLAN', 'INFORME_FINAL', 'SUSTENTACION')),
    CONSTRAINT CHK_Eval_Condicion CHECK (Condicion IS NULL OR Condicion IN (
        'APROBADO', 'OBS_MENORES', 'OBS_MAYORES', 'DESAPROBADO'
    )),
    CONSTRAINT CHK_Eval_Puntaje
        CHECK (PuntajeObtenido IS NULL OR PuntajeObtenido BETWEEN 0 AND 40)
);
GO

-- ------------------------------------------------------------
-- T20: DICTAMEN_ETICA
-- Pronunciamiento del Comité de Ética (Art. 24° inc. c, 34°)
-- ------------------------------------------------------------
CREATE TABLE Evaluacion.DictamenEtica (
    IdDictamen      INT             NOT NULL IDENTITY(1,1),
    IdTrabajo       INT             NOT NULL,
    Etapa           VARCHAR(15)     NOT NULL,   -- PLAN, INFORME_FINAL
    Resultado       VARCHAR(10)     NOT NULL,   -- CONFORME, OBSERVADO
    Observaciones   NVARCHAR(2000)  NULL,
    FechaDictamen   DATE            NULL,
    CONSTRAINT PK_DictamenEtica PRIMARY KEY (IdDictamen),
    CONSTRAINT FK_Dictamen_Trabajo
        FOREIGN KEY (IdTrabajo) REFERENCES Tramite.TrabajoInvestigacion(IdTrabajo),
    CONSTRAINT CHK_Dictamen_Etapa
        CHECK (Etapa IN ('PLAN', 'INFORME_FINAL')),
    CONSTRAINT CHK_Dictamen_Resultado
        CHECK (Resultado IN ('CONFORME', 'OBSERVADO'))
);
GO

-- ------------------------------------------------------------
-- T21: CONTROL_SIMILITUD
-- Control antiplagio - máximo 3 intentos (Art. 7°, Art. 35° inc. e)
-- ------------------------------------------------------------
CREATE TABLE Evaluacion.ControlSimilitud (
    IdControl       INT             NOT NULL IDENTITY(1,1),
    IdTrabajo       INT             NOT NULL,
    NroIntento      TINYINT         NOT NULL,   -- 1, 2 o 3 (máximo)
    Porcentaje      DECIMAL(5,2)    NOT NULL,
    Resultado       VARCHAR(10)     NOT NULL,   -- CONFORME, OBSERVADO
    FechaRevision   DATE            NOT NULL,
    NroConstancia   VARCHAR(60)     NULL,
    CONSTRAINT PK_ControlSimilitud PRIMARY KEY (IdControl),
    CONSTRAINT FK_CtrlSim_Trabajo
        FOREIGN KEY (IdTrabajo) REFERENCES Tramite.TrabajoInvestigacion(IdTrabajo),
    CONSTRAINT CHK_CtrlSim_Intento
        CHECK (NroIntento BETWEEN 1 AND 3),
    CONSTRAINT CHK_CtrlSim_Porcentaje
        CHECK (Porcentaje BETWEEN 0 AND 100),
    CONSTRAINT CHK_CtrlSim_Resultado
        CHECK (Resultado IN ('CONFORME', 'OBSERVADO')),
    CONSTRAINT UQ_CtrlSim_Trabajo_Intento
        UNIQUE (IdTrabajo, NroIntento)
);
GO

-- ------------------------------------------------------------
-- T22: SUSTENTACION
-- Acto de sustentación y calificación (Art. 37°, 55°, 60°)
-- Máximo 2 intentos por trabajo
-- ------------------------------------------------------------
CREATE TABLE Evaluacion.Sustentacion (
    IdSustentacion      INT             NOT NULL IDENTITY(1,1),
    IdTrabajo           INT             NOT NULL,
    NroIntento          TINYINT         NOT NULL DEFAULT 1,  -- máx 2
    FechaHora           DATETIME2       NOT NULL,
    Modalidad           VARCHAR(14)     NOT NULL DEFAULT 'PRESENCIAL',
    -- PRESENCIAL, NO_PRESENCIAL
    DuracionMinutos     TINYINT         NULL,               -- máx 45
    NotaExposicion      DECIMAL(4,2)    NULL,
    NotaDefensa         DECIMAL(4,2)    NULL,
    NotaConocimientos   DECIMAL(4,2)    NULL,  -- solo suficiencia profesional
    Condicion           VARCHAR(12)     NULL,  -- APROBADO, DESAPROBADO
    AprobacionTipo      VARCHAR(12)     NULL,  -- UNANIMIDAD, MAYORIA
    NroActa             VARCHAR(40)     NULL,
    CONSTRAINT PK_Sustentacion PRIMARY KEY (IdSustentacion),
    CONSTRAINT FK_Sust_Trabajo
        FOREIGN KEY (IdTrabajo) REFERENCES Tramite.TrabajoInvestigacion(IdTrabajo),
    CONSTRAINT CHK_Sust_Intento
        CHECK (NroIntento BETWEEN 1 AND 2),
    CONSTRAINT CHK_Sust_Modalidad
        CHECK (Modalidad IN ('PRESENCIAL', 'NO_PRESENCIAL')),
    CONSTRAINT CHK_Sust_Duracion
        CHECK (DuracionMinutos IS NULL OR DuracionMinutos <= 45),
    CONSTRAINT CHK_Sust_Notas
        CHECK (
            (NotaExposicion    IS NULL OR NotaExposicion    BETWEEN 0 AND 20) AND
            (NotaDefensa       IS NULL OR NotaDefensa       BETWEEN 0 AND 20) AND
            (NotaConocimientos IS NULL OR NotaConocimientos BETWEEN 0 AND 20)
        ),
    CONSTRAINT CHK_Sust_Condicion
        CHECK (Condicion IS NULL OR Condicion IN ('APROBADO', 'DESAPROBADO')),
    CONSTRAINT CHK_Sust_Aprobacion
        CHECK (AprobacionTipo IS NULL OR AprobacionTipo IN ('UNANIMIDAD', 'MAYORIA')),
    CONSTRAINT UQ_Sust_Trabajo_Intento
        UNIQUE (IdTrabajo, NroIntento)
);
GO

-- ============================================================
-- 10. TABLAS DE DOCUMENTOS
-- ============================================================

-- ------------------------------------------------------------
-- T23: RESOLUCION
-- Resoluciones emitidas durante el proceso (Art. 24°, 34°, 36°)
-- ------------------------------------------------------------
CREATE TABLE Documento.Resolucion (
    IdResolucion    INT             NOT NULL IDENTITY(1,1),
    IdTramite       INT             NOT NULL,
    TipoResolucion  VARCHAR(30)     NOT NULL,
    -- APROBACION_PLAN, DESIGNACION_ASESOR, DESIGNACION_JURADO,
    -- EXPEDITO, APROBACION_BACHILLER, APROBACION_TITULO,
    -- CAMBIO_TITULO, CAMBIO_ASESOR, CAMBIO_JURADO, AMPLIACION_PLAZO
    NroResolucion   VARCHAR(50)     NOT NULL,
    FechaEmision    DATE            NOT NULL,
    OrganoEmisor    VARCHAR(25)     NOT NULL,
    -- DECANO, CONSEJO_FACULTAD, CONSEJO_UNIVERSITARIO
    Descripcion     VARCHAR(500)    NULL,
    CONSTRAINT PK_Resolucion PRIMARY KEY (IdResolucion),
    CONSTRAINT FK_Resolucion_Tramite
        FOREIGN KEY (IdTramite) REFERENCES Tramite.Tramite(IdTramite),
    CONSTRAINT UQ_Resolucion_Nro UNIQUE (NroResolucion),
    CONSTRAINT CHK_Resolucion_Tipo CHECK (TipoResolucion IN (
        'APROBACION_PLAN',      'DESIGNACION_ASESOR',
        'DESIGNACION_JURADO',   'EXPEDITO',
        'APROBACION_BACHILLER', 'APROBACION_TITULO',
        'CAMBIO_TITULO',        'CAMBIO_ASESOR',
        'CAMBIO_JURADO',        'AMPLIACION_PLAZO'
    )),
    CONSTRAINT CHK_Resolucion_Organo CHECK (OrganoEmisor IN (
        'DECANO', 'CONSEJO_FACULTAD', 'CONSEJO_UNIVERSITARIO'
    ))
);
GO

-- ------------------------------------------------------------
-- T24: DIPLOMA
-- Diploma de bachiller o título profesional (Art. 9°, 11°)
-- ------------------------------------------------------------
CREATE TABLE Documento.Diploma (
    IdDiploma           INT             NOT NULL IDENTITY(1,1),
    IdTramite           INT             NOT NULL,
    TipoDiploma         VARCHAR(20)     NOT NULL,   -- BACHILLER, TITULO_PROFESIONAL
    NroDiploma          VARCHAR(40)     NULL,
    FechaExpedicion     DATE            NULL,
    FechaRegistroSunedu DATE            NULL,
    FirmanteRector      VARCHAR(150)    NULL,
    FirmanteDecano      VARCHAR(150)    NULL,
    FirmanteSecretario  VARCHAR(150)    NULL,
    EsDuplicado         BIT             NOT NULL DEFAULT 0,
    FechaDuplicado      DATE            NULL,
    MotivosDuplicado    VARCHAR(200)    NULL,  -- PERDIDA, DETERIORO
    CONSTRAINT PK_Diploma PRIMARY KEY (IdDiploma),
    CONSTRAINT FK_Diploma_Tramite
        FOREIGN KEY (IdTramite) REFERENCES Tramite.Tramite(IdTramite),
    CONSTRAINT UQ_Diploma_Nro
        UNIQUE (NroDiploma),
    CONSTRAINT CHK_Diploma_Tipo
        CHECK (TipoDiploma IN ('BACHILLER', 'TITULO_PROFESIONAL')),
    CONSTRAINT CHK_Diploma_Duplicado
        CHECK (EsDuplicado = 0 OR MotivosDuplicado IS NOT NULL)
);
GO

-- ------------------------------------------------------------
-- T25: OBSERVACION_TRAMITE
-- Observaciones y subsanaciones durante el proceso (Art. 15°, 35°)
-- ------------------------------------------------------------
CREATE TABLE Tramite.ObservacionTramite (
    IdObservacion           INT             NOT NULL IDENTITY(1,1),
    IdTramite               INT             NOT NULL,
    TipoObservacion         VARCHAR(15)     NOT NULL,
    -- FORMATO, METODOLOGIA, ETICA, SIMILITUD, ADMINISTRATIVA
    Descripcion             NVARCHAR(2000)  NOT NULL,
    FechaObservacion        DATE            NOT NULL DEFAULT CAST(SYSDATETIME() AS DATE),
    PlazoSubsanacionDias    SMALLINT        NULL,
    FechaSubsanacion        DATE            NULL,
    Estado                  VARCHAR(12)     NOT NULL DEFAULT 'PENDIENTE',
    -- PENDIENTE, SUBSANADO, ARCHIVADO
    CONSTRAINT PK_ObservacionTramite PRIMARY KEY (IdObservacion),
    CONSTRAINT FK_Obs_Tramite
        FOREIGN KEY (IdTramite) REFERENCES Tramite.Tramite(IdTramite),
    CONSTRAINT CHK_Obs_Tipo CHECK (TipoObservacion IN (
        'FORMATO', 'METODOLOGIA', 'ETICA', 'SIMILITUD', 'ADMINISTRATIVA'
    )),
    CONSTRAINT CHK_Obs_Estado
        CHECK (Estado IN ('PENDIENTE', 'SUBSANADO', 'ARCHIVADO')),
    CONSTRAINT CHK_Obs_Plazo
        CHECK (PlazoSubsanacionDias IS NULL OR PlazoSubsanacionDias > 0)
);
GO

-- ============================================================
USE GradosTitulos;
GO
-- ============================================================
-- 11. ÍNDICES PARA OPTIMIZACIÓN DE CONSULTAS
-- ============================================================

-- Persona
CREATE NONCLUSTERED INDEX IX_Persona_DNI
    ON Academico.Persona(DNI);

CREATE NONCLUSTERED INDEX IX_Persona_Tipo
    ON Academico.Persona(TipoPersona);

-- Docente
CREATE NONCLUSTERED INDEX IX_Docente_Facultad
    ON Academico.Docente(IdFacultad);

-- ProgramaEstudios
CREATE NONCLUSTERED INDEX IX_Programa_Facultad
    ON Academico.ProgramaEstudios(IdFacultad);

-- Matricula
CREATE NONCLUSTERED INDEX IX_Matricula_Estudiante
    ON Academico.Matricula(IdEstudiante);

CREATE NONCLUSTERED INDEX IX_Matricula_Programa
    ON Academico.Matricula(IdPrograma);

-- Tramite
CREATE NONCLUSTERED INDEX IX_Tramite_Matricula
    ON Tramite.Tramite(IdMatricula);

CREATE NONCLUSTERED INDEX IX_Tramite_Estado
    ON Tramite.Tramite(IdEstadoTramite);

CREATE NONCLUSTERED INDEX IX_Tramite_Tipo
    ON Tramite.Tramite(IdTipoTramite);

-- TrabajoInvestigacion
CREATE NONCLUSTERED INDEX IX_Trabajo_Tramite
    ON Tramite.TrabajoInvestigacion(IdTramite);

CREATE NONCLUSTERED INDEX IX_Trabajo_Tipo
    ON Tramite.TrabajoInvestigacion(TipoTrabajo);

-- EvaluacionTrabajo
CREATE NONCLUSTERED INDEX IX_Eval_Trabajo
    ON Evaluacion.EvaluacionTrabajo(IdTrabajo);

CREATE NONCLUSTERED INDEX IX_Eval_Etapa
    ON Evaluacion.EvaluacionTrabajo(EtapaEvaluacion);

-- Sustentacion
CREATE NONCLUSTERED INDEX IX_Sust_Trabajo
    ON Evaluacion.Sustentacion(IdTrabajo);

-- Resolucion
CREATE NONCLUSTERED INDEX IX_Res_Tramite
    ON Documento.Resolucion(IdTramite);

CREATE NONCLUSTERED INDEX IX_Res_Tipo
    ON Documento.Resolucion(TipoResolucion);

-- ============================================================
USE GradosTitulos;
GO
-- ============================================================
-- 12. VISTAS (reemplazan dependencias transitivas - 3FN)
-- ============================================================

-- ------------------------------------------------------------
-- V01: Condición de egresado (elimina dependencia transitiva
--      en Matricula.condicion_egresado)
-- ------------------------------------------------------------
CREATE OR ALTER VIEW Academico.V_CondicionEgresado
AS
SELECT
    m.IdMatricula,
    m.IdEstudiante,
    p.DNI,
    p.Nombres + ' ' + p.ApellidoPaterno + ' ' +
        ISNULL(p.ApellidoMaterno,'')                AS NombreCompleto,
    m.IdPrograma,
    pr.NombrePrograma,
    m.FechaMatricula,
    m.CreditosAprobados,
    m.AsignaturasAprobadas,
    m.PracticasCompletadas,
    m.IdiomaAprobado,
    m.ProyeccionSocial,
    m.TieneDeuda,
    CASE
        WHEN m.AsignaturasAprobadas = 1
         AND m.PracticasCompletadas = 1
         AND m.IdiomaAprobado       = 1
         AND m.ProyeccionSocial     = 1
         AND m.TieneDeuda           = 0
        THEN CAST(1 AS BIT)
        ELSE CAST(0 AS BIT)
    END                                             AS EsEgresado
FROM Academico.Matricula          m
JOIN Academico.Persona            p  ON p.IdPersona  = m.IdEstudiante
JOIN Academico.ProgramaEstudios   pr ON pr.IdPrograma = m.IdPrograma;
GO

-- ------------------------------------------------------------
-- V02: Estado actual del trabajo (elimina dependencia
--      transitiva estado ← porcentaje_similitud)
-- ------------------------------------------------------------
CREATE OR ALTER VIEW Tramite.V_EstadoTrabajo
AS
SELECT
    t.IdTrabajo,
    t.IdTramite,
    t.TipoTrabajo,
    t.Titulo,
    t.ModalidadAutoria,
    CASE
        WHEN EXISTS (
            SELECT 1 FROM Evaluacion.Sustentacion s
            WHERE s.IdTrabajo = t.IdTrabajo
              AND s.Condicion = 'APROBADO'
        ) THEN 'SUSTENTADO_APROBADO'
        WHEN EXISTS (
            SELECT 1 FROM Evaluacion.Sustentacion s
            WHERE s.IdTrabajo = t.IdTrabajo
              AND s.Condicion = 'DESAPROBADO'
        ) THEN 'SUSTENTADO_DESAPROBADO'
        WHEN EXISTS (
            SELECT 1 FROM Evaluacion.ControlSimilitud cs
            WHERE cs.IdTrabajo = t.IdTrabajo
              AND cs.Resultado = 'CONFORME'
        ) THEN 'SIMILITUD_CONFORME'
        WHEN EXISTS (
            SELECT 1 FROM Tramite.DesignacionJurado dj
            WHERE dj.IdTrabajo = t.IdTrabajo
              AND dj.Estado    = 'DESIGNADO'
        ) THEN 'EN_REVISION_JURADO'
        WHEN EXISTS (
            SELECT 1 FROM Tramite.DesignacionAsesor da
            WHERE da.IdTrabajo = t.IdTrabajo
              AND da.Estado    = 'ACTIVO'
        ) THEN 'EN_DESARROLLO'
        ELSE 'INSCRITO'
    END AS EstadoActual
FROM Tramite.TrabajoInvestigacion t;
GO

-- ------------------------------------------------------------
-- V03: Nota final de sustentación (elimina dependencia
--      transitiva nota_final ← notas parciales)
-- Art. 42°: nota mín. 13; fracción >= 0.5 sube a la unidad
-- ------------------------------------------------------------
CREATE OR ALTER VIEW Evaluacion.V_NotaFinalSustentacion
AS
SELECT
    s.IdSustentacion,
    s.IdTrabajo,
    s.NroIntento,
    s.FechaHora,
    s.Modalidad,
    s.NotaExposicion,
    s.NotaDefensa,
    s.NotaConocimientos,
    s.AprobacionTipo,
    -- Nota final calculada según tipo de aprobación (Art. 43°)
    CASE
        WHEN s.AprobacionTipo = 'UNANIMIDAD'
            THEN ROUND(
                (ISNULL(s.NotaExposicion,0) + ISNULL(s.NotaDefensa,0))
                / NULLIF(
                    CASE WHEN s.NotaExposicion IS NOT NULL THEN 1 ELSE 0 END +
                    CASE WHEN s.NotaDefensa    IS NOT NULL THEN 1 ELSE 0 END, 0
                ), 0)
        WHEN s.AprobacionTipo = 'MAYORIA'
            THEN ROUND(
                (
                    SELECT AVG(CAST(e.PuntajeObtenido AS FLOAT))
                    FROM Evaluacion.EvaluacionTrabajo e
                    WHERE e.IdTrabajo       = s.IdTrabajo
                      AND e.EtapaEvaluacion = 'SUSTENTACION'
                      AND e.PuntajeObtenido >= 13
                ), 0)
        ELSE NULL
    END                                                 AS NotaFinalCalculada,
    -- Calificación literal (Art. 42°)
    CASE
        WHEN ROUND(
                (ISNULL(s.NotaExposicion,0) + ISNULL(s.NotaDefensa,0)) /
                NULLIF(
                    CASE WHEN s.NotaExposicion IS NOT NULL THEN 1 ELSE 0 END +
                    CASE WHEN s.NotaDefensa    IS NOT NULL THEN 1 ELSE 0 END, 0
                ), 0) >= 19 THEN 'EXCELENTE'
        WHEN ROUND(
                (ISNULL(s.NotaExposicion,0) + ISNULL(s.NotaDefensa,0)) /
                NULLIF(
                    CASE WHEN s.NotaExposicion IS NOT NULL THEN 1 ELSE 0 END +
                    CASE WHEN s.NotaDefensa    IS NOT NULL THEN 1 ELSE 0 END, 0
                ), 0) >= 17 THEN 'MUY_BUENO'
        WHEN ROUND(
                (ISNULL(s.NotaExposicion,0) + ISNULL(s.NotaDefensa,0)) /
                NULLIF(
                    CASE WHEN s.NotaExposicion IS NOT NULL THEN 1 ELSE 0 END +
                    CASE WHEN s.NotaDefensa    IS NOT NULL THEN 1 ELSE 0 END, 0
                ), 0) >= 15 THEN 'BUENO'
        WHEN ROUND(
                (ISNULL(s.NotaExposicion,0) + ISNULL(s.NotaDefensa,0)) /
                NULLIF(
                    CASE WHEN s.NotaExposicion IS NOT NULL THEN 1 ELSE 0 END +
                    CASE WHEN s.NotaDefensa    IS NOT NULL THEN 1 ELSE 0 END, 0
                ), 0) >= 13 THEN 'REGULAR'
        ELSE 'DESAPROBADO'
    END                                                 AS CalificacionLiteral,
    s.Condicion                                         AS CondicionRegistrada,
    s.NroActa
FROM Evaluacion.Sustentacion s;
GO

-- ============================================================
USE GradosTitulos;
GO
-- ============================================================
-- 13. FUNCIONES AUXILIARES
-- ============================================================

-- ------------------------------------------------------------
-- F01: Ciclo mínimo para presentar plan de tesis (Art. 22°)
--      Elimina dependencia: num_semestres → ciclo_minimo
-- ------------------------------------------------------------
CREATE OR ALTER FUNCTION Academico.F_CicloMinimoPlan
(
    @NumSemestres TINYINT
)
RETURNS TINYINT
AS
BEGIN
    RETURN CASE @NumSemestres
        WHEN 10 THEN 9
        WHEN 12 THEN 11
        WHEN 14 THEN 13
        ELSE NULL
    END;
END;
GO

-- ------------------------------------------------------------
-- F02: Verificar si similitud es aceptable (Art. 7°: máx 30%)
-- ------------------------------------------------------------
CREATE OR ALTER FUNCTION Evaluacion.F_SimilitudAceptable
(
    @Porcentaje DECIMAL(5,2)
)
RETURNS BIT
AS
BEGIN
    RETURN CASE WHEN @Porcentaje < 30.00 THEN 1 ELSE 0 END;
END;
GO

-- ============================================================
USE GradosTitulos;
GO
-- ============================================================
-- 14. STORED PROCEDURES PRINCIPALES
-- ============================================================

-- ------------------------------------------------------------
-- SP01: Registrar nuevo trámite completo
-- ------------------------------------------------------------
CREATE OR ALTER PROCEDURE Tramite.SP_RegistrarTramite
    @IdMatricula    INT,
    @IdTipoTramite  TINYINT,
    @IdCoordinacion TINYINT,
    @IdTramite      INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar que la matrícula exista
        IF NOT EXISTS (SELECT 1 FROM Academico.Matricula WHERE IdMatricula = @IdMatricula)
            THROW 50001, 'La matrícula especificada no existe.', 1;

        -- Validar que no tenga trámite activo del mismo tipo
        IF EXISTS (
            SELECT 1 FROM Tramite.Tramite
            WHERE IdMatricula   = @IdMatricula
              AND IdTipoTramite = @IdTipoTramite
              AND IdEstadoTramite NOT IN (5, 6, 7)  -- no terminales
        )
            THROW 50002, 'Ya existe un trámite activo del mismo tipo.', 1;

        INSERT INTO Tramite.Tramite (
            IdMatricula, IdTipoTramite, IdEstadoTramite, IdCoordinacion
        )
        VALUES (
            @IdMatricula, @IdTipoTramite, 1, @IdCoordinacion
        );

        SET @IdTramite = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- ------------------------------------------------------------
-- SP02: Registrar resultado de sustentación
-- ------------------------------------------------------------
CREATE OR ALTER PROCEDURE Evaluacion.SP_RegistrarSustentacion
    @IdTrabajo          INT,
    @FechaHora          DATETIME2,
    @Modalidad          VARCHAR(14),
    @NotaExposicion     DECIMAL(4,2),
    @NotaDefensa        DECIMAL(4,2),
    @NotaConocimientos  DECIMAL(4,2)  = NULL,
    @AprobacionTipo     VARCHAR(12),
    @NroActa            VARCHAR(40),
    @IdSustentacion     INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verificar intentos disponibles (máx 2 por Art. 44°)
        DECLARE @NroIntento TINYINT;
        SELECT @NroIntento = ISNULL(MAX(NroIntento), 0) + 1
        FROM Evaluacion.Sustentacion
        WHERE IdTrabajo = @IdTrabajo;

        IF @NroIntento > 2
            THROW 50003, 'Se superó el máximo de 2 intentos de sustentación.', 1;

        -- Calcular nota final y condición
        DECLARE @NotaFinal DECIMAL(4,2);
        SET @NotaFinal = ROUND((@NotaExposicion + @NotaDefensa) / 2.0, 1);

        -- Ajuste fracción >= 0.5 sube a unidad (Art. 42°)
        IF (@NotaFinal - FLOOR(@NotaFinal)) >= 0.5
            SET @NotaFinal = CEILING(@NotaFinal);
        ELSE
            SET @NotaFinal = FLOOR(@NotaFinal);

        DECLARE @Condicion VARCHAR(12);
        SET @Condicion = CASE WHEN @NotaFinal >= 13 THEN 'APROBADO' ELSE 'DESAPROBADO' END;

        INSERT INTO Evaluacion.Sustentacion (
            IdTrabajo, NroIntento, FechaHora, Modalidad,
            NotaExposicion, NotaDefensa, NotaConocimientos,
            Condicion, AprobacionTipo, NroActa
        )
        VALUES (
            @IdTrabajo, @NroIntento, @FechaHora, @Modalidad,
            @NotaExposicion, @NotaDefensa, @NotaConocimientos,
            @Condicion, @AprobacionTipo, @NroActa
        );

        SET @IdSustentacion = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- ============================================================
USE GradosTitulos;
GO
-- ============================================================
-- 15. VERIFICACIÓN FINAL DEL ESQUEMA
-- ============================================================
SELECT
    s.name                          AS Esquema,
    t.name                          AS Tabla,
    COUNT(c.column_id)              AS NroColumnas,
    SUM(CASE WHEN ic.index_id IS NOT NULL THEN 1 ELSE 0 END) AS NroIndices
FROM sys.tables      t
JOIN sys.schemas     s   ON s.schema_id = t.schema_id
JOIN sys.columns     c   ON c.object_id = t.object_id
LEFT JOIN (
    SELECT DISTINCT ic.object_id, ic.index_id
    FROM sys.index_columns ic
) ic ON ic.object_id = t.object_id
WHERE s.name IN ('Catalogo','Academico','Tramite','Evaluacion','Documento')
GROUP BY s.name, t.name
ORDER BY s.name, t.name;
GO

SELECT
    s.name      AS Esquema,
    v.name      AS Vista
FROM sys.views  v
JOIN sys.schemas s ON s.schema_id = v.schema_id
WHERE s.name IN ('Academico','Tramite','Evaluacion')
ORDER BY s.name, v.name;
GO

PRINT '========================================================';
PRINT ' Base de datos GradosTitulos creada exitosamente.';
PRINT ' Tablas   : 25';
PRINT ' Vistas   :  3 (V_CondicionEgresado, V_EstadoTrabajo,';
PRINT '                 V_NotaFinalSustentacion)';
PRINT ' Funciones:  2 (F_CicloMinimoPlan, F_SimilitudAceptable)';
PRINT ' SPs      :  2 (SP_RegistrarTramite, SP_RegistrarSust.)';
PRINT ' Esquemas :  5 (Catalogo, Academico, Tramite,';
PRINT '                 Evaluacion, Documento)';
PRINT '========================================================';
GO

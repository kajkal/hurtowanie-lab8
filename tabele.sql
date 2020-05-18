DROP TABLE IF EXISTS [hurtownie].[dbo].[lab8_fakt_OPERACJE]
DROP TABLE IF EXISTS [hurtownie].[dbo].[lab8_tmp_POLACZENIA]
DROP TABLE IF EXISTS [hurtownie].[dbo].[lab8_wymiar_STARTY]
DROP TABLE IF EXISTS [hurtownie].[dbo].[lab8_wymiar_LADOWANIA]
DROP TABLE IF EXISTS [hurtownie].[dbo].[lab8_wymiar_LOTNISKA]


CREATE TABLE [hurtownie].[dbo].[lab8_wymiar_LOTNISKA] (
    [airport_code_iata] varchar(50),
    [name] varchar(100),
    [city] varchar(50),
    [country] varchar(50),
    [code_icao] varchar(50),
    [lat] real,
    [lon] real,
    [alt] real,
    [offsetfromutc] real,
    [dst] varchar(1),
    [timezone] varchar(50),
    [type] varchar(50),
    [source] varchar(50),

    CONSTRAINT PK_IATA_code_lab8 PRIMARY KEY CLUSTERED ([airport_code_iata])
)

CREATE TABLE [hurtownie].[dbo].[lab8_wymiar_STARTY] (
    [takeoff] datetime,
    [takeoff_hour] int,
    [takeoff_day] int,
    [takeoff_week] int,
    [takeoff_month] int,
    [takeoff_date] date,
    
    CONSTRAINT PK_takeoff_id_lab8 PRIMARY KEY CLUSTERED ([takeoff])
)

CREATE TABLE [hurtownie].[dbo].[lab8_wymiar_LADOWANIA] (
    [landing] datetime,
    [landing_hour] int,
    [landing_day] int,
    [landing_week] int,
    [landing_month] int,
    [landing_date] date,
    
    CONSTRAINT PK_landing_id_lab8 PRIMARY KEY CLUSTERED ([landing])
)

CREATE TABLE [hurtownie].[dbo].[lab8_tmp_POLACZENIA] (
    [id] bigint,
    [src_iata_code] varchar(50),
    [dst_iata_code] varchar(50),
    [international] bit,
    [flight_distance] float,
    [fuel_consumption_rate] float,

    CONSTRAINT PK_polaczenie_id_lab8 PRIMARY KEY CLUSTERED ([id]),

    CONSTRAINT FK_polaczenie_src_airport_IATA_lab8 FOREIGN KEY ([src_iata_code])
    REFERENCES [hurtownie].[dbo].[lab8_wymiar_LOTNISKA] ([airport_code_iata]),
    CONSTRAINT FK_polaczenie_dst_airport_IATA_lab8 FOREIGN KEY ([dst_iata_code])
    REFERENCES [hurtownie].[dbo].[lab8_wymiar_LOTNISKA] ([airport_code_iata])
)

CREATE TABLE [hurtownie].[dbo].[lab8_fakt_OPERACJE] (
    [id] bigint,
    [takeoff] datetime,
    [landing] datetime,
    [src_iata_code] varchar(50),
    [dst_iata_code] varchar(50),
    [international] bit,
    [flight_distance] float,
    [fuel_consumption_rate] float,
    [fuel_consumption] float,
    [occup] smallint,
    [occup_pct] real,
    [occup_max] real,

    CONSTRAINT PK_operation_id_lab8 PRIMARY KEY CLUSTERED ([id]),

    CONSTRAINT FK_takeoff_id_lab8 FOREIGN KEY ([takeoff])
    REFERENCES [hurtownie].[dbo].[lab8_wymiar_STARTY] ([takeoff]),
    CONSTRAINT FK_landing_id_lab8 FOREIGN KEY ([landing])
    REFERENCES [hurtownie].[dbo].[lab8_wymiar_LADOWANIA] ([landing]),

    CONSTRAINT FK_src_airport_IATA_lab8 FOREIGN KEY ([src_iata_code])
    REFERENCES [hurtownie].[dbo].[lab8_wymiar_LOTNISKA] ([airport_code_iata]),
    CONSTRAINT FK_dst_airport_IATA_lab8 FOREIGN KEY ([dst_iata_code])
    REFERENCES [hurtownie].[dbo].[lab8_wymiar_LOTNISKA] ([airport_code_iata])
)

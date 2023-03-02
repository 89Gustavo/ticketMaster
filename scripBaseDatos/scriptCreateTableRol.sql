create table rol(
	idRol int identity(1,1),
	nombreRol nvarchar(64),
	descripcionRol nvarchar(512),
	estatus int,
	usurioCrea nvarchar(64),
	fechaCrea date,
	usurioModifica nvarchar(64),
	fechaModifica date,
	CONSTRAINT FK_rol PRIMARY KEY(idRol asc)
)
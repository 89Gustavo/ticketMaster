create table ususuario(
	idUsuario int identity(1,1),
	idPersona int,
	idRol int,
	usuario nvarchar(64),
	contrasenia nvarchar(128),
	estatus int,
	usuarioCrea nvarchar(64),
	fechaCrea date,
	usuarioModifica nvarchar(64),
	fechaModifica date,
	CONSTRAINT FK_idUsuario PRIMARY KEY (idUsuario asc),
	CONSTRAINT PK_idPersona FOREIGN KEY (idPersona) REFERENCES persona(idPersona) 
)
USE [ticketmaster]
GO
/****** Object:  StoredProcedure [dbo].[spr_insertPersona]    Script Date: 02/03/2023 10:17:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spr_insertPersona]
	@idPersona int,
	@primerNombre nvarchar(64),
	@segundoNombre nvarchar(64),
	@tercerNombre nvarchar(64),
	@primerApellido nvarchar(64),
	@segundoApellido nvarchar(64),
	@apellidoCasada nvarchar(64),
	@genero int,
	@fechaNacimiento date,
	@dpi varchar(16),
	@nit varchar(16),
	@correo nvarchar(64),
	@USUARIO_BITACORA nvarchar(64)

	
AS
begin try
	declare @XML varchar(max)
	declare @METODO varchar(16)
	declare @SP varchar(64)
	set @METODO = 'INSERT'
	set @SP = 'spr_insertPersona'

	
	set @XML = '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>0</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE/><STACK_TRACE/></MSGPRE>'

	--se agrega comentario para la creacion de personas
	IF (@idPersona =0)
		BEGIN
			Insert Into persona(primerNombre, segundoNombre, tercerNombre, primerApellido, segundoApellido, apellidoCasada, genero, fechaNacimiento, dpi, nit, correo, estatus, usuarioCrea,fechaCrea)
			values (@primerNombre, @segundoNombre, @tercerNombre, @primerApellido, @segundoApellido, @apellidoCasada, @genero,@fechaNacimiento, @dpi, @nit, @correo,1, @USUARIO_BITACORA, GETDATE())

		END
	ELSE
		BEGIN
			UPDATE persona set
				primerNombre = @primerNombre,
				segundoNombre = @segundoNombre,
				tercerNombre = @tercerNombre, 
				primerApellido = @primerApellido, 
				segundoApellido = @segundoNombre,
				apellidoCasada = @apellidoCasada, 
				genero = @genero, 
				fechaNacimiento = @fechaNacimiento, 
				dpi = @dpi, 
				nit = @nit, 
				correo = @correo,
				usuarioModifica = @USUARIO_BITACORA,
				fechaModifica = GETDATE()
			WHERE idPersona = @idPersona
		END
		
end try
begin catch
	set @XML = '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>1</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE><![CDATA['+ ERROR_MESSAGE() +']]></MENSAJE><STACK_TRACE><![CDATA[' + cast(ERROR_NUMBER() as nvarchar(50)) + ' del error ocurrido en ' + isnull(ERROR_PROCEDURE(),'') + ' en la línea ' + cast(ERROR_LINE() as nvarchar(50)) + ']]></STACK_TRACE></MSGPRE>'
end catch

select @XML

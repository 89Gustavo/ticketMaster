USE [ticketmaster]
GO
/****** Object:  StoredProcedure [dbo].[spr_postActualizarEstatus]    Script Date: 02/03/2023 11:15:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spr_postActualizarEstatus] 
	@idPersona int
	
AS 
BEGIN TRY 
     DECLARE @METODO VARCHAR(16) 
     DECLARE @SP VARCHAR(64) 
     SET @METODO = 'SELECT' 
     SET @SP = 'spr_getListarPersonas' 

     SELECT '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>0</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE/><STACK_TRACE/></MSGPRE>' as xmlRespuesta 
	 
	 select idPersona, primerNombre, segundoNombre, tercerNombre, primerApellido, segundoApellido, apellidoCasada, genero, fechaNacimiento, dpi, nit, correo from persona where estatus = 1 and idPersona = @idPersona

END TRY 
BEGIN CATCH 
     SELECT '<MSGPRE><ORIGEN>SQL</ORIGEN><PROYECTO/><METODO>' + @METODO + '</METODO><CODIGO>1</CODIGO><PROCEDIMIENTO>' + @SP + '</PROCEDIMIENTO><MENSAJE><![CDATA['+ ERROR_MESSAGE() +']]></MENSAJE><STACK_TRACE><![CDATA[' + cast(ERROR_NUMBER() as nvarchar(50)) + ' del error ocurrido en ' + isnull(ERROR_PROCEDURE(),'') + ' en la l�nea ' + cast(ERROR_LINE() as nvarchar(50)) + ']]></STACK_TRACE></MSGPRE>' as xmlRespuesta 
END CATCH

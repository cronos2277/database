select cast(
            day(aniversario) as varchar) + '/' 
            + cast(month(aniversario) as varchar) + '/' 
            + cast(year(aniversario) as varchar)
as 'Data de Aniversario' from exemplo_data
GO
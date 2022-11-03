

			select 
			    a.nome,
				u.numero, 
				u.status, 
				u.statusGovernanca,
				bu.id,
				bu.Nome,
				u.Observacao,
				u.ObservacaoUh
			
			from uh u 
				inner join TipoUH tu on u.TipoUH = tu.id
				inner join hotel h on tu.Hotel = h.id
				inner join blocouh bu on u.BlocoUh = bu.id
				inner join andar a on u.andar = a.id
					
			where 
				h.id = 4 and
				u.numero = '1101';
				


select * from uh where numero = '1101';

select * from UhStatusGovernanca where id =( SELECT MAX(ID) FROM UhStatusGovernanca);

select * from UhStatusGovernanca where uh = 3;

select * from UhStatusGovernanca where uh = 7
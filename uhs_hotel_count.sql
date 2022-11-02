

			select 
				u.status,
				count(u.id)	total		
			from uh u 
				inner join TipoUH tu on u.TipoUH = tu.id
				inner join hotel h on tu.Hotel = h.id
				inner join blocouh bu on u.BlocoUh = bu.id
				inner join andar a on u.andar = a.id
					
			where 
				h.id = 4
			group by u.status
			;


			select 
				u.statusGovernanca,
				count(u.id)	total		
			from uh u 
				inner join TipoUH tu on u.TipoUH = tu.id
				inner join hotel h on tu.Hotel = h.id
				inner join blocouh bu on u.BlocoUh = bu.id
				inner join andar a on u.andar = a.id
					
			where 
				h.id = 4
			group by u.StatusGovernanca
			;


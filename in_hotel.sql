		select 
                r.id reserva,
                p.nome, 
				r.QuantidadeAdulto,
				r.QuantidadeCrianca1,
				r.QuantidadeCrianca2,
                r.CheckIn, 
                r.CheckOut, 
                u.Numero UH,
				r.status,
				h.nome
            from 
                reserva r
                inner join ReservaCliente rc on r.id = rc.Reserva
                inner join cliente c on rc.cliente = c.id
                inner join pessoa p on c.pessoa = p.id
                inner join uh u on r.UH = u.id
				inner join TipoUH tu on r.TipoUh = tu.id
				inner join hotel h on tu.Hotel = h.id
			where 
				r.status = 'CI' and
				rc.Principal = 'S'and 
				h.id = 7
				order by u.Numero;



			select * from Reserva where id =249492;




		select 
                count(r.id)
            from 
                reserva r
                inner join ReservaCliente rc on r.id = rc.Reserva
                inner join cliente c on rc.cliente = c.id
                inner join pessoa p on c.pessoa = p.id
                inner join uh u on r.UH = u.id
            where 
                r.status = 'CI'
                and rc.Principal = 'S'
                and r.TipoUh in(1,2,3,4,5,6,7);


			select * from UH where TipoUH in(1,2,3,4,5,6,7) and pool = 'S'; and StatusGovernanca <> 'T';

			select * from uh where id = 572;

			select * from TipoUH;

			select * from hotel where id = 4;
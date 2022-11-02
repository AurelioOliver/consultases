

			select 
				sum(r.QuantidadeAdulto) Adulto,
				sum(r.quantidadeCrianca1) Crianca1,
				sum(r.quantidadeCrianca2) Crianca2
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
				h.id = 4;

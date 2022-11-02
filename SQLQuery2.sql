		select 
                r.id reserva,
                p.nome, 
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
				r.id = 299306;
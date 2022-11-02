		
	-- LISTA DE CHEGADA teste
		
		select 
                r.id reserva,
				th.Nome tipo,
                p.nome, 
                r.CheckIn, 
                r.CheckOut, 
                u.Numero UH,
				u.StatusGovernanca governanca,
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
				inner join TipoHospede th on th.id = r.TipoHospede
			where 
				r.status in ('CF','AC') and
				rc.Principal = 'S'and 
				r.CheckInPrevisao > '2022-10-03 00:00:00.000' and
				r.CheckInPrevisao < '2022-10-03 23:59:00.000' and
				h.id = 4
				order by u.Numero;


	-- TOTAL DE CHEGADAS

			select 
                COUNT(r.id)

            from 
                reserva r
                inner join ReservaCliente rc on r.id = rc.Reserva
                inner join cliente c on rc.cliente = c.id
                inner join pessoa p on c.pessoa = p.id
                inner join uh u on r.UH = u.id
				inner join TipoUH tu on r.TipoUh = tu.id
				inner join hotel h on tu.Hotel = h.id
				inner join TipoHospede th on th.id = r.TipoHospede
			where 
				r.status in ('CF','AC') and
				rc.Principal = 'S'and 
				r.CheckInPrevisao > '2022-10-04 00:00:00.000' and
				r.CheckInPrevisao < '2022-10-04 23:59:00.000' and
				h.id = 4;


	-- TOTAL DE SAIDAS

	
			select 
                COUNT(r.id)

            from 
                reserva r
                inner join ReservaCliente rc on r.id = rc.Reserva
                inner join cliente c on rc.cliente = c.id
                inner join pessoa p on c.pessoa = p.id
                inner join uh u on r.UH = u.id
				inner join TipoUH tu on r.TipoUh = tu.id
				inner join hotel h on tu.Hotel = h.id
				inner join TipoHospede th on th.id = r.TipoHospede
			where 
				r.status in ('CI') and
				rc.Principal = 'S'and 
				r.CheckOutPrevisao > '2022-09-29 00:00:00.000' and
				r.CheckOutPrevisao < '2022-09-29 23:59:00.000' and
				h.id = 7;

			select
			    Convert (Varchar, Day(r.CheckInPrevisao)) + '/' + Convert (Varchar, Month(r.CheckInPrevisao)) + '/' + Convert (Varchar, Year(r.CheckInPrevisao)) Data,
				count(r.CheckInPrevisao) Qtd

            from 
                reserva r
                 inner join uh u on r.UH = u.id
				inner join TipoUH tu on r.TipoUh = tu.id
				inner join hotel h on tu.Hotel = h.id
			where 
				r.status in ('CF','AC') and
				r.CheckInPrevisao >= '2022-09-29' and
				r.CheckInPrevisao <= '2022-10-10 23:59:00.000' and
				h.id = 7
			group by r.CheckInPrevisao
				;


				select * from reserva r
					inner join uh u on r.UH = u.id
					inner join TipoUH tu on r.TipoUh = tu.id
					inner join hotel h on tu.Hotel = h.id
				where 				
				--r.status in ('CF','AC') and
				r.CheckIn >= '2022-10-5 00:00:00.000' and
				r.CheckIn <= '2022-10-5 23:59:00.000' and
				h.id = 7

				select * from reserva r 
					inner join uh u on r.UH = u.id
					inner join TipoUH tu on r.TipoUh = tu.id
					inner join hotel h on tu.Hotel = h.id
				where 
				 r.status = 'CF' and
				 --r.status = 'AC' and
				 r.CheckIn >= '2022-10-5 00:00:00.000' and
				 r.CheckIn <= '2022-10-5 23:59:00.000'
				 --r.id =7



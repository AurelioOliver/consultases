

			select 
				r.id,
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
				h.id = 4 
				--and r.id = 290110
				--and bu.id = 1
				
			Order by a.nome;


			-- TODOS OS HOSPEDES DA UH
			select 
				p.nome, rc.Principal 
			from reserva r
			inner join ReservaCliente rc on rc.Reserva = r.id
			inner join cliente c on c.id = rc.Cliente
			inner join pessoa p on p.id = c.Pessoa
			where 
				r.uh = 4 and r.status = 'CI';

			-- RESERVA DA UH
			select 
				u.numero,
				r.uh,
				r.id, 
				p.nome as Hospede,
				p.CPF,
				r.CheckIn,
				r.CheckOut,
				tp.nome
			from reserva r
			inner join ReservaCliente rc on rc.Reserva = r.id
			inner join cliente c on c.id = rc.Cliente
			inner join pessoa p on p.id = c.Pessoa
			inner join tipohospede tp on tp.id = r.TipoHospede
			inner join uh u on u.id = r.uh
			where 
				u.numero = '1102' and
				r.status = 'CI' and
				r.hotel = 4 and
				rc.Principal = 'S';


		-- ACOMPANHANTES
			select 
				p.nome
			from reserva r
			inner join ReservaCliente rc on rc.Reserva = r.id
			inner join cliente c on c.id = rc.Cliente
			inner join pessoa p on p.id = c.Pessoa
			inner join tipohospede tp on tp.id = r.TipoHospede
			inner join uh u on u.id = r.uh
			where 
				u.numero = '2401' and
				r.status = 'CI' and
				r.hotel = 4 and
				rc.Principal = 'N';




			select * from reserva where id = 290110;
			select * from ReservaCliente where reserva = 290110;
			select * from cliente where id = 668588;
			select * from pessoa where id = 807117;
			select * from uh where id = 4;

			select * from ReservaVeiculo where reserva = 290110;

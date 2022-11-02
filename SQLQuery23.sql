Select 
	r.Id, 
	r.CheckIn as CheckIn, 
	r.CheckOut as CheckOut, 
	r.DataHoraConfirmacao as DataConfirmacao, 
	r.DataHoraAConfirmar, 
	r.Status as Status,
	grh.nome as GrupoNome, 
	r.TipoReservaImobiliaria, 
	r.TelefoneReservante, 
	r.emailreservante,
	coalesce((select top 1 email from pessoaemail where pessoa = p.id) COLLATE Latin1_General_CI_AI,'') as Email,
	coalesce((select top 1 Numero from PessoaTelefone where pessoa = p.id and Preferencial = 'S') 
	COLLATE Latin1_General_CI_AI,'') as Telefone,
	rc.Incognito, 
	Case 
		When r.Status = 'CF' Then 'Confirmada' 
		When r.Status = 'CI' Then 'CheckIn' 
		When r.Status = 'CO' Then 'CheckOut' 
		When r.Status = 'CP' Then 'Conta pendente' 
		When r.Status = 'NS' Then 'No Show' 
		When r.Status = 'CL' Then 'Cancelada' 
		When r.Status = 'AC' Then 'A Confirmar' 
	End as StatusNome, 
	r.NomeReservante, 
	r.EmailReservante, 
	r.VoucherEmpresa, 
	Case 
		When r.TipoPensao = 'CF' Then 'Café da Manha' 
		When r.TipoPensao = 'MA' Then 'Meia Almoço' 
		When r.TipoPensao = 'MJ' Then 'Meia Jantar' 
		When r.TipoPensao = 'PC' Then 'Pensão Completa' Else 'Nenhuma' 
	end as TipoPensao,
	Case 
		When r.GaranteNoShow = 'S' Then 'Sim' 
		When r.GaranteNoShow = 'N' Then 'Não' 
	End as NoShow, 
		( 
			Select Count(Id) as Quantidade From ReservaCliente Where Reserva = r.Id ) as QuantidadePessoaReservaCliente,
			(r.QuantidadeAdulto + r.QuantidadeCrianca1 + r.QuantidadeCrianca2) as QuantidadePessoaReserva, 
			r.QuantidadeAdulto, 
			r.QuantidadeCrianca1, 
			r.QuantidadeCrianca2, 
			Case 
				th.DestacarHospede when 'S' then '(' + th.Nome + ')' + ' - ' + p.Nome else p.nome 
			end as HospedeNome, 
			Case p.Tipo when 'J' then 
				Case th.DestacarHospede when 'S' then '(' + th.Nome + ')' + ' - ' + p.NomeFantasia else p.NomeFantasia end else '' end as HospedeNomeFantasia, 
	tu.Nome as TipoUhNome, 
	uh.Numero as UhNumero, 
	o.Nome as OrigemNome, 
	sm.Nome as SegmentoNome, 
	mc.Nome as MeioComunicacaoNome, 
	r.Observacao, 
	r.ObservacaoIntegracao, 
	Coalesce(grh.Observacao,'') as ObservacaoGrupoHospedagem, 
	us.Login as Usuario, 
	r.DataHora as DataReserva, 
	pEmp.Nome as Empresa, 
	pEmp.NomeFantasia as EmpresaNomeFantasia,
	uC1.Numero as UHConectada1, 
	uC2.Numero as UHConectada2, 
	(th.Codigo + ' - ' + th.Nome) as TipoHospedeNome, 
	COALESCE((select SUM(rd1.ValorTarifa) from ReservaDiaria rd1 join Reserva r1 on r1.Id = rd1.Reserva where r1.Id = r.Id group by rd1.Reserva),0) as ValorDiariaTotal, 
	COALESCE((select SUM(rd1.ValorTarifa) from ReservaDiaria rd1 join Reserva r1 on r1.Id = rd1.Reserva where r1.Id = r.Id and CONVERT(date, rd1.DataHora) = CONVERT(date, GETDATE()) group by rd1.Reserva),0) as ValorDiariaDiaAtual, 
	COALESCE((select SUM(rd1.ValorTarifa) from ReservaDiaria rd1 join Reserva r1 on r1.Id = rd1.Reserva where r1.Id = r.Id and CONVERT(date, rd1.DataHora) = CONVERT(date, r1.Checkin) group by rd1.DataHora),0) as ValorDiariaDiaPrimeiraDiaria, 
	COALESCE((select SUM(rd1.ValorTarifa + rd1.ValorPensao + rd1.ValorCafeManha) from ReservaDiaria rd1 join Reserva r1 on r1.Id = rd1.Reserva where r1.Id = r.Id group by rd1.Reserva),0) as ValorDiariaPensaoTotal, 
	COALESCE((select SUM(rd1.ValorTarifa + rd1.ValorPensao + rd1.ValorCafeManha) from ReservaDiaria rd1 join Reserva r1 on r1.Id = rd1.Reserva where r1.Id = r.Id and CONVERT(date, rd1.DataHora) = CONVERT(date, GETDATE()) group by rd1.Reserva),0) as ValorDiariaPensaoDiaAtual, 
	COALESCE((select SUM(rd1.ValorTarifa + rd1.ValorPensao + rd1.ValorCafeManha) from ReservaDiaria rd1 join Reserva r1 on r1.Id = rd1.Reserva where r1.Id = r.Id and CONVERT(date, rd1.DataHora) = CONVERT(date, r1.Checkin) group by rd1.DataHora),0) as ValorDiariaPensaoDiaPrimeiraDiaria, 
	COALESCE((select SUM(rd1.ValorPensao + rd1.ValorCafeManha) from ReservaDiaria rd1 join Reserva r1 on r1.Id = rd1.Reserva where r1.Id = r.Id group by rd1.Reserva),0) as ValorPensaoTotal, 
	COALESCE((select SUM(rd1.ValorPensao + rd1.ValorCafeManha) from ReservaDiaria rd1 join Reserva r1 on r1.Id = rd1.Reserva where r1.Id = r.Id and CONVERT(date, rd1.DataHora) = CONVERT(date, GETDATE()) group by rd1.Reserva),0) as ValorPensaoDiaAtual, 
	COALESCE((select SUM(rd1.ValorPensao + rd1.ValorCafeManha) from ReservaDiaria rd1 join Reserva r1 on r1.Id = rd1.Reserva where r1.Id = r.Id and CONVERT(date, rd1.DataHora) = CONVERT(date, r1.Checkin) group by rd1.DataHora),0) as ValorPensaoDiaPrimeiraDiaria, 
	r.Walkin, 
	r.DataHoraCancelamento, 
	r.ObservacaoCancelamento,
	m.Descricao as MotivoCancelamento,
	r.TipoTarifacao, 
	thh.Nome as TarifarioNome, 
	case 
		when r.TipoTarifacao = 'T' then COALESCE(r.Desconto, 0) else 0 end as Desconto,
		case r.TipoUtilizacao 
			when 'I' then 'Intercambiadora' 
			when 'P' then 'Pool' 
			when 'U' then 'Uso proprietário' 
			when 'C' then 'Uso Convidado' else r.TipoUtilizacao end as TipoUtilizacao, 
			case 
				when th.Id is not null then COALESCE(th.UtilizadoPool, 'S') 
				when r.Uh is null then tu.EntraDisponibilidade 
				when h.Condominio is null then 
				case 
					when uh.Pool is null then tu.EntraDisponibilidade else uh.Pool end else 
						case 
							when (
								Select COUNT(tu.id) From TipoUh tu 
									INNER JOIN Hotel h ON h.Id = tu.Hotel 
									INNER JOIN UhCondominio uc ON uc.Id = uh.UHCondominio 
									INNER JOIN CotaProprietario cp ON cp.UhCondominio = uc.Id 
									INNER JOIN Cota ct ON ct.Id = cp.Cota 
									INNER JOIN PeriodoCotaDisponibilidade pc ON pc.Cota = ct.Id and pc.UhCondominio = uc.Id 
									INNER JOIN PeriodoCotaDisponibilidadePool pcu ON pcu.PeriodoCotaDisponibilidade = pc.Id 
								Where 
									tu.Id = uh.TipoUh and 
									pc.DataHoraExclusao is null and 
									Cast(pcu.DataHoraInclusao as date) <=  Cast(coalesce(r.Checkin,getdate()) as date)  And 
									(pcu.DataHoraExclusao is null or pcu.DataHoraExclusao >  Cast(coalesce(r.Checkin,getdate()) as date) ) and  
									Cast(coalesce(r.Checkin,getdate()) as date)  >= pc.DataInicial and  
									Cast(coalesce(r.Checkin,getdate()) as date)  <= pc.DataFinal ) = 0 then 'N' else 'S' end end  as Pool , r.IdIntegracao,'' as Ticketours, idm.Id as Idioma, idm.Nome as NomeIdioma From Reserva r 
										INNER JOIN ReservaCliente rc ON rc.Reserva = r.Id and rc.Principal = 'S' ]
										INNER JOIN Cliente c ON rc.Cliente = c.Id 
										INNER JOIN Pessoa p ON p.Id = c.Pessoa  
										INNER JOIN TipoUh tu ON tu.Id = r.TipoUh 
										INNER JOIN Hotel h ON h.Id = tu.Hotel 
										LEFT OUTER JOIN Motivo m on m.id = r.MotivoCancelamento 
										LEFT OUTER JOIN UH uh ON uh.Id = r.Uh 
										LEFT OUTER JOIN UH uC1 ON uC1.Id = uh.UHConectada1 
										LEFT OUTER JOIN UH uC2 ON uC2.Id = uh.UHConectada2 
										LEFT OUTER JOIN OrigemReserva o ON o.Id = r.OrigemReserva 
										LEFT OUTER JOIN GrupoHospedagem grh ON grh.Id = r.grupohospedagem 
										Inner Join Usuario us on us.Id = r.Usuario 
										LEFT OUTER JOIN Cliente cEmp ON cEmp.Id = r.EmpresaHospedagem 
										LEFT OUTER JOIN Pessoa pEmp ON pEmp.Id = cEmp.Pessoa 
										LEFT OUTER JOIN TipoHospede th ON th.Id = r.TipoHospede 
										LEFT OUTER JOIN TarifarioHospedagem thh on thh.Id = r.TarifarioHospedagem 
										left join SegmentoMercado sm on sm.Id = r.SegmentoMercado 
										left join MeioComunicacao mc on mc.Id = r.MeioComunicacao 
										left join PessoaIdioma psi on psi.Pessoa = p.Id and psi.IdiomaPrincipal = 'S' 
										left join Idioma idm on idm.id = psi.Idioma 
									Where 
										r.hotel = 7 and 
										r.CheckInPrevisao >= '10/05/2022' and 
										r.CheckInPrevisao <= '10/05/2022 23:59:59.998' and 
										r.Status in ('AC','CF')
Select
    (Convert (Varchar, Day(r.CheckOut)) + '/' + Convert (Varchar, Month(r.CheckOut)) + '/' + Convert (Varchar, Year(r.CheckOut))) as DataCheckOut,
	Count(r.Id) as QuantidadeCheckOut, 
	Coalesce(SUM(r.QuantidadeAdulto + r.QuantidadeCrianca1 + r.QuantidadeCrianca2),0) as QuantidadeHospede
From Reserva r 
	INNER JOIN TipoUH tu ON tu.Id = r.TipoUH 
	LEFT OUTER JOIN UH uh ON uh.Id = r.UH 
	LEFT OUTER JOIN Hotel h ON tu.Hotel = h.Id 
	left join TipoHospede th on th.Id = r.TipoHospede
Where r.Hotel = 7 And 
	r.CheckOut >= '09/30/2022' And 
	r.CheckOut <= '10/07/2022 23:59:59' And
	(r.Status = 'CI' Or r.Status = 'CF' Or r.Status = 'AC')
Group By (Convert (Varchar, Day(r.CheckOut)) + '/' + Convert (Varchar, Month(r.CheckOut)) + '/' + Convert (Varchar, Year(r.CheckOut))) 
Order By (Convert (Varchar, Day(r.CheckOut)) + '/' + Convert (Varchar, Month(r.CheckOut)) + '/' + Convert (Varchar, Year(r.CheckOut)));


Select 
	(Convert (Varchar, Day(r.CheckIn))  + '/' + Convert (Varchar, Month(r.CheckIn))  + '/' + Convert (Varchar, Year(r.CheckIn))) as DataCheckIn,
	Count(r.Id) as QuantidadeCheckIn, 
	coalesce(SUM(r.QuantidadeAdulto + r.QuantidadeCrianca1 + r.QuantidadeCrianca2),0) as QuantidadeHospede
From Reserva r 
	INNER JOIN TipoUH tu ON tu.Id = r.TipoUH 
	LEFT OUTER JOIN UH uh ON uh.Id = r.UH 
	LEFT OUTER JOIN Hotel h ON tu.Hotel = h.Id 
	left join TipoHospede th on th.Id = r.TipoHospede 
Where 
	r.Hotel = 7 And
	r.CheckIn >= '09/30/2022' And 
	r.CheckIn <= '10/07/2022 23:59:59'  And
	(r.Status = 'CF' Or r.Status = 'AC' or r.Status = 'CI') 
Group By (Convert (Varchar, Day(r.CheckIn)) + '/' + Convert (Varchar, Month(r.CheckIn)) + '/' + Convert (Varchar, Year(r.CheckIn)))
Order By (Convert (Varchar, Day(r.CheckIn)) + '/' + Convert (Varchar, Month(r.CheckIn)) + '/' + Convert (Varchar, Year(r.CheckIn)));




Select 
	SUM(r.QuantidadeAdulto + r.QuantidadeCrianca1 + r.QuantidadeCrianca2) as QuantidadeHospede 
From 
	Reserva r 
	INNER JOIN TipoUH tu ON tu.Id = r.TipoUH 
	LEFT OUTER JOIN UH uh ON uh.Id = r.UH 
	LEFT OUTER JOIN Hotel h ON tu.Hotel = h.Id 
	left join TipoHospede th on th.Id = r.TipoHospede 
Where r.Hotel = 7 And 
	r.CheckIn <= '10/05/2022' And
	r.Checkout > '10/05/2022 23:59:59'  And
	(r.Status = 'CF' Or r.Status = 'AC' or r.Status = 'CI');



Select r.Id as Id, r.Status as Status, r.Checkout, DateDiff(Day,r.CheckIn,r.CheckOut) as Dias, r.TipoHospede, Coalesce(th.Custo, 'N') as TipoHospedeCusto, 'N' as DesconsiderarTipoHospedeCusto From Reserva r INNER JOIN TipoUH tu ON tu.Id = r.TipoUH LEFT OUTER JOIN UH uh ON uh.Id = r.UH LEFT OUTER JOIN Hotel h ON tu.Hotel = h.Id left join TipoHospede th on th.Id = r.TipoHospede Where r.Hotel =  7 And 
r.CheckIn <= '10/05/2022 23:59:59' And r.CheckOut > '10/05/2022  23:59:59'  And (r.Status = 'CF' Or r.Status = 'AC' or r.Status = 'CI') ;
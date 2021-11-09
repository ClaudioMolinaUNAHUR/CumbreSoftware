import conocimientos.*
object cumbre {
	const property participantes = #{}
	var property commitsMinimosProgramador = 300
	const property actividadesRealizadas = #{}
	const auspiciantes = []
	const registrados = []
	
	method registrar(persona) {
		registrados.add(persona)
	}
	method conocimientosAdquiridosEnCumbre(persona){
		return persona.conocimientos().filter{c=>actividadesRealizadas.contains(c)}
	}
	method horasEmpleadasPor(persona){
		return self.conocimientosAdquiridosEnCumbre(persona).sum{c=>c.horas()}
	}
	method totalHorasDeActividadesHechas(){
		return participantes.sum{c=>self.horasEmpleadasPor(c)}
	}
	method agregarAuspiciante(pais) {
		auspiciantes.add(pais)
	}

	method ingresa(unParticipante) {
		participantes.add(unParticipante)
	}
	method esConflictivoCon(unPais){
		return auspiciantes.any{c => c.tieneConflictoCon(unPais)}
	}
	method paisesParticipantes(){
		return participantes.map({c=>c.pais()}).asSet()
	}
	method paisConMasParticipantes(){
		return self.paisesParticipantes().max{c=>self.cantParticipantesDel(c)}
	}
	method cantParticipantesDel(unPais){
		return participantes.count{c=>c.pais() == unPais}
	}
	method participantesExtranjeros(){
		return participantes.filter({c=>not auspiciantes.contains(c.pais())})
	}
	method esRelevante(){
		return participantes.all{c=>c.esCape()}
	}
	method accesoRestringido(persona){
		return self.esConflictivoCon(persona.pais())
	}
	method cumpleRequisitos(persona){
		return persona.puedeEntrar()  && self.participantesExtranjeros().size() <= 2
	}
	method dejaEntrar(persona){
		return self.cumpleRequisitos(persona) && not self.esConflictivoCon(persona.pais())
	}
	method darIngresoA(persona) {
		self.registrar(persona)
		if (self.dejaEntrar(persona))
			self.ingresa(persona)
		else
			self.error("No se le permite ingresar")
//			throw new Exception(message = "No se le permite ingresar")
	}
	method esSegura(){
		return registrados.all{pers=>self.dejaEntrar(pers)}
	}
}

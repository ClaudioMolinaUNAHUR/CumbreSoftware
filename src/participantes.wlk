import conocimientos.*
import cumbre.*

class Participante {
	var property pais
	var conocimientos = []
	var commits
	
	method agregarConocimiento(conocimiento) {conocimientos.add(conocimiento)}
	method esCape()
	
	//alternativa con super

	method condicionBasica() = conocimientos.contains(programacionBasica)
	method condicionAdicional()
	
	//alternativa sin super
	method puedeEntrar() = self.condicionBasica() && self.condicionAdicional()
	
	method hacerUnaActividad(actividad){
		conocimientos.add(actividad)
		commits += actividad.cantidadDeCommits()
	}
}

class Programador inherits Participante{
	var horasCapacitadas
	override method esCape() = commits > 500
	override method condicionAdicional() = commits >= cumbre.commitsMinimosProgramador()
	override method hacerUnaActividad(actividad) {
		super(actividad)
		horasCapacitadas += actividad.horas()
	}
}

class Especialista inherits Participante{
	override method esCape() = conocimientos.size() > 2
	override method condicionAdicional() = commits >= cumbre.commitsMinimosProgramador() - 100 && conocimientos.contains(objetos)
}
class Gerente inherits Participante{
	const property empresa
	override method esCape() = empresa.esMultinacional()
	override method condicionAdicional() = conocimientos.contains(manejoDeGrupos)
}


class Empresa {
	var paises = #{}
	method esMultinacional()= paises.size() >= 3
}
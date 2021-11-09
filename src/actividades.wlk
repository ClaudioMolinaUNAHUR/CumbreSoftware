class Actividad{
	var tema
	var horas = 0
	method cantidadDeCommits() = horas * tema.commitsPorHora()
	method horas(){
		return horas
	}
}
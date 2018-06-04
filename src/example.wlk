class Jarra {
	const litros //cantidad litros (numero)
	const marca //instancia de clase marca o sus herencias
	
	method litros() = litros
	method marca() = marca
	
	method cantidadAlcoholAportado() {
		return marca.alcoholPorLitros(litros)
	}
}



//------Cervezas------

class Marca {
	const lupulo //cantidad de lupulo por litro (numero)
	const pais //string indicando un pais
	
	method lupulo() = lupulo
	method pais() = pais
	
	method alcoholPorLitros(litros)
}

class Rubia inherits Marca {
	const graduacion //porcentaje de graduacion (numero)
	
	override method alcoholPorLitros(litros) {
		return graduacion*litros
	}
}

class Negra inherits Marca {
	override method alcoholPorLitros(litros) {
		return #{lupulo, reglasMundiales.graduacion()}.min()
	}
}

class Roja inherits Negra {
	override method alcoholPorLitros(litros) {
		return super(litros) * 1.25
	}
}

object reglasMundiales {
	var graduacion //porcentaje de graduacion (numero)
	
	method graduacion() = graduacion
	method cambioGraduacionNegras(nuevaGraduacion) {
		graduacion = nuevaGraduacion
	}
}


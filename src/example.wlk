class Carpa {
	const capacidad //numero personas
	const tieneMusica //booleano
	const jarras //CONJUNTO de jarras de igual marca
	var genteAdentro //LISTA de personas
	
	method marca() {
		return jarras.first({jarra => jarra.marca()})
	}
	method tieneMusica() = tieneMusica
	method capacidad() = capacidad
	
	method permiteIngresoA(personaX) {
		return genteAdentro.size()+1 <= capacidad and !personaX.estaEbria()
	}
	
	method entra(personaX) {
		genteAdentro.add(personaX)
	}
}


//------Personas------

class Persona {
	const peso //numero
	const leGustaLaMusicaTradicional //booleano
	const aguante //numero
	var jarrasDeCerveza //LISTA de jarras
	var marcasQueLeGustan //CONJUNTO de marcas
	
	method comprarCerveza(jarra) {
		jarrasDeCerveza.add(jarra)
	}
	
	method litrosDeAlcoholIngeridos() {
		return jarrasDeCerveza.sum({jarra => jarra.cantidadAlcoholAportado()})
	}
	
	method estaEbria() {
		return self.litrosDeAlcoholIngeridos()*peso > aguante
	}
	
	
	method quiereEntrarACarpa(carpaX) {
		return self.leGustaMarca(carpaX.marca()) and self.coincideMusica(carpaX)
	}
	method leGustaMarca(marcaX)
	method coincideMusica(carpaX) {
		return (leGustaLaMusicaTradicional == carpaX.tieneMusica())
	}
	
	method puedeEntrarA(carpaX) {
		return self.quiereEntrarACarpa(carpaX) and carpaX.permiteIngresoA(self)
	}
	
	method entrarA(carpaX) {
		if (self.puedeEntrarA(carpaX)) {
			carpaX.entra(self)
		} else {
			self.error("No se cumplen las condiciones necesarias para permitir ingreso")
		}
	}
}

class Belga inherits Persona {
	override method leGustaMarca(marcaX) {
		return marcaX.lupulo() > 4
	}
}

class Checos inherits Persona {
	override method leGustaMarca(marcaX) {
		return marcaX.graduacion() > 0.08
	}
}

class Aleman inherits Persona {
	override method leGustaMarca(marcaX) {
		return true
	}
	
	override method quiereEntrarACarpa(carpaX) {
		return super(carpaX) and (carpaX.capacidad() % 2 == 0)
	}
}


//------Jarras------

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
	method graduacion()
}

class Rubia inherits Marca {
	const graduacion //porcentaje de graduacion (numero)
	
	override method graduacion() = graduacion
	
	override method alcoholPorLitros(litros) {
		return graduacion*litros
	}
}

class Negra inherits Marca {
	override method graduacion() = reglasMundiales.graduacion()
	
	override method alcoholPorLitros(litros) {
		return #{lupulo, self.graduacion()}.min()
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


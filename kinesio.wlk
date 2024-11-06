class Paciente {
    var edad
    var fortalezaMuscular
    var dolor
    const property rutina = []

    method edad() = edad
    method fortalezaMuscular() = fortalezaMuscular
    method dolor() = dolor
    method cumplirAnios() {
        edad = edad + 1
    }
    method cargarRutina(unaLista) {
        rutina.clear()
        rutina.addAll(unaLista)
    }

    method disminuirDolor(unValor) {
        dolor = 0.max(dolor - unValor)
    }

    method aumentarFortaleza(unValor) {
        fortalezaMuscular = fortalezaMuscular + unValor
    }

    method puedeUsar(unAparato) = unAparato.puedeSerUsadoPor(self)

    method usar(unAparato) {
        if(self.puedeUsar(unAparato))
            unAparato.consecuenciaDelUso(self)
    }

    method puedeHacerRutina() {
        return rutina.all({ a => self.puedeUsar(a)})
    }

    method realizarRutina() {
        rutina.forEach({a => self.usar(a)})
    }
}                         

class Resistente inherits Paciente {
    override method realizarRutina() {
        const cantidad = rutina.count({a => self.puedeUsar(a)})
        super()
        self.aumentarFortaleza(cantidad)
    }//el orden importa
}

class Caprichoso inherits Paciente {
    override method puedeHacerRutina() {
        return self.hayAlgunAparatoRojo() && super()
    }

    method hayAlgunAparatoRojo() = rutina.any({a => a.color() == "rojo"})

    override method realizarRutina() {
        super()
        super()
    }
}

class RecuperacionRapida inherits Paciente {

    override method realizarRutina() {
        super()
        self.disminuirDolor(disminucionDolor.valor()) //lo mismo para todos los pacientes
        
    }
}

object disminucionDolor { //lo mismo para todos los pacientes //obj unico que usan todos
  var property valor = 3 
}



class Aparato {
    var property color = "blanco"

    method consecuenciaDelUso(unPaciente)

    method puedeSerUsadoPor(unPaciente)

    method recibirMantenimiento() {}

    method necesitaMantenimiento() = false
}


class Magneto inherits Aparato {
    var imantacion = 800

    override method consecuenciaDelUso(unPaciente) {
        unPaciente.disminuirDolor(unPaciente.dolor() * 0.1)
        imantacion = 0.max(imantacion - 1)
    }

    override method puedeSerUsadoPor(unPaciente) = true

    override method recibirMantenimiento() {
        imantacion = 800.min(imantacion + 500)
    }

    override method necesitaMantenimiento() = imantacion < 100
}



class Bici inherits Aparato {
    var tornillos = 0 
    var aceite = 0

    override method consecuenciaDelUso(unPaciente) {
        self.uso(unPaciente)
        unPaciente.disminuirDolor(4)
        unPaciente.aumentarFortaleza(3)
    }

    method uso(unPaciente) {
        if(unPaciente.dolor() >= 30) {
            tornillos = tornillos + 1
            if(unPaciente.edad().between(30, 50)) //y ademas
                aceite = aceite + 1
        }
    }

    override method puedeSerUsadoPor(unPaciente) = unPaciente.edad() > 8

    override method necesitaMantenimiento() = tornillos >= 10 || aceite >= 5

    override method recibirMantenimiento() {
        tornillos = 0
        aceite = 0
    }
}



class Minitramp inherits Aparato {
    override method consecuenciaDelUso(unPaciente) {
        unPaciente.aumentarFortaleza(unPaciente.edad() * 0.1)
    }

    override method puedeSerUsadoPor(unPaciente) = unPaciente.dolor() < 20

}



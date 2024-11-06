object centro {
    const property aparatos = []
    const property pacientes = []

    method agregarAparatos(unaLista) {
        aparatos.addAll(unaLista)
    }

    method agregarPacientes(unaLista) {
        pacientes.addAll(unaLista)
    }

    method colorAparatos() = aparatos.map({a => a.color()}).asSet()

    method pacientesMenoresA(unValor) = pacientes.filter({p => p.edad() < unValor})

    method cantNoPuedenCumplirRutina() = pacientes.count({p => not p.puedeHacerRutina()})

    method optimas() = aparatos.all({a => not a.necesitaMantenimiento()})

    method estoyComplicado() = self.cantNecesitanMantenimiento() >= aparatos.size().div(2) //da entero != a / 2

    method cantNecesitanMantenimiento() = aparatos.count({a => a.necesitaMantenimiento()})

    method realizarMancenimiento() {
        self.aparatosQueNecesitanMantenimiento().forEach({a => a.recibirMantenimiento()})
    }

    method aparatosQueNecesitanMantenimiento() = aparatos.filter({a => a.necesitaMantenimiento()})
}
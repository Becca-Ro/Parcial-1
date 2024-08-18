class Criatura{
    var property salud
}

class Estudiante inherits Criatura{
    var property casa 
    var property habilidad
    var property hechizosAprendidos = []
    var property sangrePura 

    method peligroso()= (salud != 0) && casa.peligroso(self)

    method aprenderHechizo(hechizo){
        hechizosAprendidos.add(hechizo)
    }

    method aumentarHabilidad() {
        habilidad += casa.aumento()
    }
     
    method lanzarHechizo(hechizo, objetivo){
        hechizo.efecto(objetivo)
    }

    method cambiarCasa(){
        casa = casa.casaOpuesta()
    }

    method anotarse(materia){
        materia.inscribirAlumno(self)
    }

    method darseDeBaja(materia){
        materia.darDeBaja(self)
    }
}

object gryffindor{

    var property aumento = 4

    method peligroso(estudiante)= false

    method casaOpuesta(){
        return slytherin
    }

}

object slytherin{
    var property aumento = 3

    method peligroso(estudiante) = true

      method casaOpuesta(){
        return gryffindor
    }
}

object hufflepuff{
    var property aumento = 1

     method peligroso(estudiante) = estudiante.sangrePura()

       method casaOpuesta(){
        return ravenclaw
    }
}

object ravenclaw{
    var property aumento = 1

    method peligroso(estudiante)= estudiante.habilidad() > 10

      method casaOpuesta(){
        return hufflepuff
    }
}

class Profesor inherits Estudiante{
    var property hechizoQueEnsenia
}

class Materia{
    var property profesor
    var property inscriptos = []

    method inscribirAlumno(estudiante){
        inscriptos.add(estudiante)
    }

    method dictarMateria(){
        inscriptos.forEach({alumno => (alumno.aprenderHechizo(profesor.hechizoQueEnsenia())) && alumno.habilidad(alumno.aumentarHabilidad())})
    }

    method practica(criatura){
        inscriptos.forEach({alumno => alumno.lanzarHechizo(profesor.hechizoQueEnsenia(), criatura)})
    }

    method darDeBaja(estudiante){
        inscriptos.remove(estudiante)
    }
    }

class HechizoComun{
    var property dificultad

    method puedeLanzar(estudiante) = estudiante.habilidad() > dificultad

    method efecto(estudiante,objetivo) {
        objetivo.salud(objetivo.salud() - self.potencia())   
    }

    method potencia() = 0.8 * dificultad + 10


    method actuar(estudiante, objetivo){
        if (self.puedeLanzar(estudiante)){
            self.efecto(estudiante,objetivo)
        }
        else{
            throw new Error (message= "el estudiante no tiene habilidad suficiente o no sabe el hechizo")

        }
    }
}

class HechizoImperdonable inherits HechizoComun{
 var property danio

    override method efecto(estudiante, objetivo){
        super() 
        estudiante.salud(estudiante.salud()-danio)
    }   
    
    override method potencia() = super() * 2
}

class HechizoPeligroso inherits HechizoComun{
    override method puedeLanzar(estudiante)= !estudiante.peligroso()

    override method efecto(estudiante, objetivo){
        super() 
        objetivo.habilidad(objetivo.habilidad() -1 )
    }
    
}

class HechizoNuevo inherits HechizoComun{

    override method puedeLanzar(estudiante)= estudiante.SangrePura()

    override method efecto(estudiante, objetivo){
        super()
        objetivo.cambiarCasa()
    }
}

class Error inherits Exception { }


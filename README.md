# Chain of Responsability

![Pattern](https://img.shields.io/badge/Behavioral-Patterns-green.svg)
![Languages](https://img.shields.io/badge/Language-swift-green.svg)

### Motivación
¿Tienes un conjunto de clases que resuelven problemas y no sabes cuál de ellas es la mejor? ¿Tu código acaba siendo un conjunto de ifs entrelazados para escoger quién resuelve las tareas?

¡Deja al código que escoja! Pero siempre, con patrones y estilo!

### Idea
**Crear una cadena de responsabilidad en donde cada clase escoge si ella propia resuelve el problema o si debe mandarlo a la siguiente en la cadena de responsabilidad.**

### Problema

Pasar de:

```swift
let problem = Problem(powerRequired: .Good, name: "Save the world")

if batman.resolveProblem(problem: problem) {
    
    batman.resolveProblem(problem: problem)

} else if spiderman.resolveProblem(problem: problem) {

    spiderman.resolveProblem(problem: problem)

} else if wolverine.resolveProblem(problem: problem) {
    
    wolverine.resolveProblem(problem: problem)
    
} else if thor.resolveProblem(problem: problem) {
    
    thor.resolveProblem(problem: problem)

} else {
    
    print("There are not more super heros. The world is over :(")
}
```

a:

```swift
let problem = Problem(powerRequired: .Good, name: "Save the world")

var shield = Shield(firstSuperHeros: humanSuperHeros)

shield.resolveProblem(problem: $0)
```

### Solución

Dentro del playground podréis ver la implementación de este pequeño ejemplo de una forma corta, elegante y fácil de entender. Construyendo diferentes tipos de super héroes que resuelven diferentes tipos de problemas.

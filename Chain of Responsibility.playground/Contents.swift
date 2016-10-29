// Example of the Chain of Responsibility Pattern
// This is a very usefull behavioral pattern used to delegate tasks between classes

enum Power: Int {
    
    case Human = 1, Mutant, Good
}

class Problem {
    
    let powerRequired: Power
    let name: String
    var completed: Bool = false
    
    init(powerRequired: Power, name: String) {
        
        self.powerRequired = powerRequired
        self.name = name
    }
}

class SuperHero {
    
    let power: Power
    let name: String
    var isBusy: Bool = false
    
    init(power: Power, name: String) {
        
        self.power = power
        self.name = name
    }
    
    func resolveProblem(problem: Problem) -> Bool {
        
        if problem.powerRequired.rawValue > self.power.rawValue || self.isBusy {
            
            print("\(self.name) is not stronger enough to win \(problem.name)")
            return false
        
        } else {
            
            self.isBusy = true
            print("\(self.name) with power \(self.power) win \(problem.name)")
            problem.completed = true
            self.isBusy = false
            return true
        }
    }
}

class SuperHeroGroup {
    
    var superHeros: [SuperHero]
    var nextLevel: SuperHeroGroup?
    let power: Power
    
    init(superHeros: [SuperHero], nextLevel: SuperHeroGroup?, power: Power) {
        
        self.superHeros = superHeros
        self.nextLevel = nextLevel
        self.power = power
    }
    
    func resolveProblemOrPassItUp(problem: Problem) -> Bool {
        
        if problem.powerRequired.rawValue > self.power.rawValue || superHeros.filter({$0.isBusy == false}).count == 0 {
            
            if let nextLevel = self.nextLevel {
                
                return nextLevel.resolveProblemOrPassItUp(problem: problem)
                
            } else {
                
                print("There are not super heros to resolve this problem. End of the world :(")
                return false
            }
        
        } else {
            
            if let firstSuperHeroAvailable = superHeros.filter({$0.isBusy == false}).first {
                
                return firstSuperHeroAvailable.resolveProblem(problem: problem)
            }
            
            print("This never will happend because our groups of super heros are by power")
            return false
        }
    }
}

class Shield {
    
    private let firstSuperHeros: SuperHeroGroup
    
    init(firstSuperHeros: SuperHeroGroup) {
    
        self.firstSuperHeros = firstSuperHeros
    }
    
    func resolveProblem(problem: Problem) -> Bool {
        
        return firstSuperHeros.resolveProblemOrPassItUp(problem: problem)
    }
}

var thor = SuperHero(power: .Good, name: "Thor")
var goodSuperHeros = SuperHeroGroup(superHeros: [thor], nextLevel: nil, power: .Good)

var spiderman = SuperHero(power: .Mutant, name: "Spider Man")
var wolverine = SuperHero(power: .Mutant, name: "Wolverine")
var mutantSuperHeros = SuperHeroGroup(superHeros: [spiderman, wolverine], nextLevel: goodSuperHeros, power: .Mutant)

var batman = SuperHero(power: .Human, name: "Batman")
var ironman = SuperHero(power: .Human, name: "Ironman")
var humanSuperHeros = SuperHeroGroup(superHeros: [batman, ironman], nextLevel: mutantSuperHeros, power: .Human)

var shield = Shield(firstSuperHeros: humanSuperHeros)

var problems = [Problem(powerRequired: .Mutant, name:"Magneto"),
                Problem(powerRequired: .Human, name:"Misterio"),
                Problem(powerRequired: .Good, name:"Loki"),
                Problem(powerRequired: .Human, name:"Kingpin"),
                Problem(powerRequired: .Human, name:"Green Gobling")]

problems.map { shield.resolveProblem(problem: $0)}

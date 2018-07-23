//: Playground - noun: a place where people can play

import UIKit

var volunteerCounts = [1,3,40,32,2,53,77,13]

let newCounts = volunteerCounts.sorted()

volunteerCounts.sort { $0 < $1 }
volunteerCounts

//func sortAscending(_ i: Int, _ j: Int) -> Bool {
//    return i < j
//}
//
//let volunteersSorted = volunteerCounts.sorted(by: sortAscending)

//let volunteersSorted = volunteerCounts.sorted { (i: Int, j: Int) -> Bool in
//    return i < j
//}

//let volunteersSorted = volunteerCounts.sorted(by: { i, j in i < j })

//let sorted = volunteerCounts.sorted(by: { $0 < $1 })

//let sorted = volunteerCounts.sorted { $0 < $1 }

func makeTownGrand(withBudget budget: Int,
                   condition: (Int) -> Bool) -> ((Int, Int) -> Int)? {
    if condition(budget) {
        func buildRoads(byAddingLights lights: Int,
                        toExistingLights existingLights: Int) -> Int {
            return lights + existingLights
        }
        return buildRoads
    } else {
        return nil }
}
func evaluate(budget: Int) -> Bool {
    return budget > 10_000
}
var stoplights = 4
if let townPlanByAddingLightsToExistingLights = makeTownGrand(withBudget: 100_000,
                                                              condition: evaluate) {
    stoplights = townPlanByAddingLightsToExistingLights(4, stoplights)
}
print("Knowhere has \(stoplights) stoplights.")



func makePopulationTracker(forInitialPopulation population: Int) -> (Int) -> Int {
    var totalPopulation = population
    func populationTracker(growth: Int) -> Int {
        totalPopulation += growth
        return totalPopulation
    }
    return populationTracker
}
var currentPopulation = 5_422
let growBy = makePopulationTracker(forInitialPopulation: currentPopulation)
growBy(500)
currentPopulation
growBy(500)
growBy(500)
currentPopulation = growBy(500)
let anotherGrowBy = growBy
anotherGrowBy(500)

let precinctPopulations = [1244, 2021, 2157]

let projectedPopulations = precinctPopulations.map { $0 * 2}
projectedPopulations

let bigProjections = projectedPopulations.filter { $0 > 4000 }
bigProjections

let totalProjection = projectedPopulations.reduce(0) { $0 + $1 }
totalProjection

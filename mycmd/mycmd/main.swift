//
//  main.swift
//  mycmd
//
//  Created by Айсен Еремеев on 21.01.2023.
//

import Foundation

print("Please enter some input\n")

let input = readLine() ?? ""
//var splittedStrings = input.split(separator: " ")
var strings: [String] = []
strings.append(input)
print(strings)
func findMostCommonLetter(commands: [String]) -> Character {
    
    var letterCounts: [Character: Int] = [:]
    for command in commands {
        let mappedLetters = command.map { ($0, 1) }
        let counts = Dictionary(mappedLetters, uniquingKeysWith: +)
        
        print(counts)
        let firstLetter = command.first!
        if letterCounts[firstLetter] == nil {
            letterCounts[firstLetter] = 1
        } else {
            letterCounts[firstLetter]! += 1
        }
    }
    var mostCommonLetter: Character = " "
    var highestCount = 0
    for (letter, count) in letterCounts {
        if count > highestCount {
            highestCount = count
            mostCommonLetter = letter
        }
    }
    return mostCommonLetter
}

let mostCommonLetter = findMostCommonLetter(commands: strings)
print(mostCommonLetter)


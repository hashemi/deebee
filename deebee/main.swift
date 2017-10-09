//
//  main.swift
//  deebee
//
//  Created by Ahmad Alhashemi on 2017-10-09.
//  Copyright © 2017 Ahmad Alhashemi. All rights reserved.
//

import Darwin

func printPrompt() {
    print("db > ", terminator: "")
}

while true {
    printPrompt()
    
    guard let input = readLine() else {
        print("Error reading input")
        exit(EXIT_FAILURE)
    }
    
    switch input {
    case ".exit":
        exit(EXIT_SUCCESS)
    default:
        print("Unrecognized command \(input)")
    }
}

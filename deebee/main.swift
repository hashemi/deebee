//
//  main.swift
//  deebee
//
//  Created by Ahmad Alhashemi on 2017-10-09.
//  Copyright © 2017 Ahmad Alhashemi. All rights reserved.
//

import Darwin

enum MetaCommandResult {
    case success, unrecognizedCommand
}

func doMetaCommand(_ input: String) -> MetaCommandResult {
    switch input {
    case ".exit":
        exit(EXIT_SUCCESS)
    default:
        return .unrecognizedCommand
    }
}

enum PrepareResult {
    case success
    case unrecognizedStatement
}

enum StatementType {
    case select, insert
}

struct Statement {
    let type: StatementType
}

func prepare_statement(_ input: String, _ statement: inout Statement?) -> PrepareResult {
    let lowercased = input.lowercased()
    
    if lowercased.hasPrefix("insert") {
        statement = Statement(type: .insert)
        return .success
    }

    if lowercased.hasPrefix("select") {
        statement = Statement(type: .select)
        return .success
    }
    
    return .unrecognizedStatement
}

func execute_statement(_ statement: inout Statement?) {
    guard let statement = statement else { return }
    switch statement.type {
    case .insert:
        print("This is where we would do an insert.")
    case .select:
        print("This is where we would do a select.")
    }
}

func printPrompt() {
    print("db > ", terminator: "")
}

while true {
    printPrompt()
    
    guard let input = readLine() else {
        print("Error reading input")
        exit(EXIT_FAILURE)
    }
    
    if input.starts(with: ".") {
        switch doMetaCommand(input) {
        case .success:
            continue
        case .unrecognizedCommand:
            print("Unrecognized command '\(input)'")
            continue
        }
    }
    
    var statement: Statement?
    switch prepare_statement(input, &statement) {
    case .success:
        break
    case .unrecognizedStatement:
        print("Unrecognized keyword at start of '\(input)'")
        continue
    }
    execute_statement(&statement)
    print("Executed.")
}

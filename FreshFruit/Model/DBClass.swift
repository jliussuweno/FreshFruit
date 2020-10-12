//
//  DBClass.swift
//  FreshFruit
//
//  Created by Jlius Suweno on 06/10/20.
//

import Foundation
import UIKit
import SQLite3

class DBClass: NSObject {
    var db: OpaquePointer?
    
    func initDB(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory , in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("database.sqlite")
        
        //Open Database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("ERROR - Error while open Database")
        } else {
            print("SUCCESS - Open Database done")
        }
        
    }
    
    func createTableUser(){
        //Create Table
        let  createTableQuery = "CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT, role TEXT)"
        
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error while create Table - \(errMsg)")
        } else {
            print("SUCCESS - Create Table done")
        }
    }
    
    func deleteSavedDataUser(){
        let deleteQuery = "DROP TABLE User"
        if sqlite3_exec(db, deleteQuery, nil, nil, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error while delete Table - \(errMsg)")
        } else {
            print("SUCCESS - Delete Table done")
        }
    }
    
    func saveDBValueFruit(inputData: User){
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        var statement: OpaquePointer?
        let name = inputData.name
        let email = inputData.email
        let password = inputData.password
        let role = inputData.role
        
        let insertQuery = "INSERT INTO FruitList (name, email, password, role) VALUES (?, ?, ?, ?)"
        
        if sqlite3_prepare(db, insertQuery, -1, &statement, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error while Prepare Insert - \(errMsg)")
            return
        } else {
            print("SUCCESS - Prepare Insert done")
        }
        
        if sqlite3_bind_text(statement, 1, name, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error Binding Statement 1 - \(errMsg)")
            return
        } else {
            print("SUCCESS - Binding Statement 1 done")
        }
        
        if sqlite3_bind_text(statement, 2, email, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error Binding Statement 2 - \(errMsg)")
            return
        } else {
            print("SUCCESS - Binding Statement 2 done")
        }
        if sqlite3_bind_text(statement, 3, password, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error Binding Statement 3 - \(errMsg)")
            return
        } else {
            print("SUCCESS - Binding Statement 3 done")
        }
        
        if sqlite3_bind_text(statement, 4, role, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error Binding Statement 4 - \(errMsg)")
            return
        } else {
            print("SUCCESS - Binding Statement 4 done")
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error Insert Statement - \(errMsg)")
            return
        } else {
            print("SUCCESS - Insert Statement done")
        }
    }
    
    func readDBValueRegister(inputData: User) -> [User] {
        var userList = [User]()
        let selectQuery = "SELECT * FROM User Where email = \'\(inputData.email)\' "
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, selectQuery, -1, &statement, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error while Prepare Select - \(errMsg)")
        } else {
            print("SUCCESS - Prepare Select done")
        }
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            let id = Int(sqlite3_column_int(statement, 0))
            let name = String(cString: sqlite3_column_text(statement, 1))
            let email = String(cString: sqlite3_column_text(statement, 2))
            let password = String(cString: sqlite3_column_text(statement, 3))
            let role = String(cString: sqlite3_column_text(statement, 4))
            
            userList.append(User(id: id, name: name, email: email, password: password, role: role))
        }
        
        return userList
    }
    
    func readDBValueLogin(inputData: User) -> [User] {
        var userList = [User]()
        let selectQuery = "SELECT * FROM User Where email = \'\(inputData.email)\' and password = \'\(inputData.password)\'"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, selectQuery, -1, &statement, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error while Prepare Select - \(errMsg)")
        } else {
            print("SUCCESS - Prepare Select done")
        }
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            let id = Int(sqlite3_column_int(statement, 0))
            let name = String(cString: sqlite3_column_text(statement, 1))
            let email = String(cString: sqlite3_column_text(statement, 2))
            let password = String(cString: sqlite3_column_text(statement, 3))
            let role = String(cString: sqlite3_column_text(statement, 4))
            
            userList.append(User(id: id, name: name, email: email, password: password, role: role))
        }
        
        return userList
    }
    
    func readDBValueUser() -> [User] {
        var userList = [User]()
        let selectQuery = "SELECT * FROM User"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, selectQuery, -1, &statement, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error while Prepare Select - \(errMsg)")
        } else {
            print("SUCCESS - Prepare Select done")
        }
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            let id = Int(sqlite3_column_int(statement, 0))
            let name = String(cString: sqlite3_column_text(statement, 1))
            let email = String(cString: sqlite3_column_text(statement, 2))
            let password = String(cString: sqlite3_column_text(statement, 3))
            let role = String(cString: sqlite3_column_text(statement, 4))
            userList.append(User(id: id, name: name, email: email, password: password, role: role))
        }
        
        return userList
    }
    
    func createTableFruit(){
        //Create Table
        let  createTableQuery = "CREATE TABLE IF NOT EXISTS FruitList (id INTEGER PRIMARY KEY AUTOINCREMENT, namefruit TEXT, price TEXT, stock TEXT, image VARCHAR)"
        
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error while create Table - \(errMsg)")
        } else {
            print("SUCCESS - Create Table done")
        }
    }
    
    func deleteSavedDataFruit(){
        let deleteQuery = "DROP TABLE FruitList"
        if sqlite3_exec(db, deleteQuery, nil, nil, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error while delete Table - \(errMsg)")
        } else {
            print("SUCCESS - Delete Table done")
        }
    }
    
    func saveDBValueFruit(inputData: Fruit){
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        var statement: OpaquePointer?
        let nameFruit = inputData.nameFruit
        let price = inputData.price
        let stock = inputData.stock
        let image = inputData.image
        
        let insertQuery = "INSERT INTO FruitList (namefruit, price, stock, image) VALUES (?, ?, ?, ?)"
        
        if sqlite3_prepare(db, insertQuery, -1, &statement, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error while Prepare Insert - \(errMsg)")
            return
        } else {
            print("SUCCESS - Prepare Insert done")
        }
        
        if sqlite3_bind_text(statement, 1, nameFruit, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error Binding Statement 1 - \(errMsg)")
            return
        } else {
            print("SUCCESS - Binding Statement 1 done")
        }
        
        if sqlite3_bind_text(statement, 2, price, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error Binding Statement 2 - \(errMsg)")
            return
        } else {
            print("SUCCESS - Binding Statement 2 done")
        }
        if sqlite3_bind_text(statement, 3, stock, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error Binding Statement 3 - \(errMsg)")
            return
        } else {
            print("SUCCESS - Binding Statement 3 done")
        }
        
        if sqlite3_bind_text(statement, 4, image, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error Binding Statement 4 - \(errMsg)")
            return
        } else {
            print("SUCCESS - Binding Statement 4 done")
        }
        
        
        if sqlite3_step(statement) != SQLITE_DONE {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error Insert Statement - \(errMsg)")
            return
        } else {
            print("SUCCESS - Insert Statement done")
        }
    }
    
    func readDBValueFruit() -> [Fruit] {
        var fruitList = [Fruit]()
        let selectQuery = "SELECT * FROM FruitList"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, selectQuery, -1, &statement, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR - Error while Prepare Select - \(errMsg)")
        } else {
            print("SUCCESS - Prepare Select done")
        }
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            let id = Int(sqlite3_column_int(statement, 0))
            let namefruit = String(cString: sqlite3_column_text(statement, 1))
            let price = String(cString: sqlite3_column_text(statement, 2))
            let stock = String(cString: sqlite3_column_text(statement, 3))
            let image = String(cString: sqlite3_column_text(statement, 4))
            fruitList.append(Fruit(id: id, nameFruit: namefruit, price: price, stock: stock, image: image))
        }
        print(fruitList)
        
        return fruitList
    }
    
}

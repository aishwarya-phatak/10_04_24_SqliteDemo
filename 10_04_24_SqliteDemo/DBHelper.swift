//
//  DBHelper.swift
//  10_04_24_SqliteDemo
//
//  Created by Vishal Jagtap on 11/06/24.
//

import Foundation
import SQLite3

class DBHelper{
    let dbPath : String = "databaseDemo.sqlite"
    var db : OpaquePointer?
    
    init(){
        db = createDatabase()
        createTable()
    }
    
    func createDatabase()->OpaquePointer?{
        var fileURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathExtension(dbPath)
        
        print("File url is \(fileURL.path)")
        
        if sqlite3_open(fileURL.path,
                        &db) == SQLITE_OK{
            print("database created successfully")
        } else {
            print("database not created")
        }
        return db
    }
    
    func createTable(){
        let createTableQueryString = 
        "CREATE TABLE IF NOT EXISTS Student(id INTEGER, name TEXT);"
        var createTableStatement : OpaquePointer?
        if sqlite3_prepare(db,
                           createTableQueryString,
                           -1,
                           &createTableStatement,
                           nil) == SQLITE_OK{
            print("statement preparation successfull")
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("table created")
            } else {
                print("table not created")
            }
        } else {
            print("statement preparation unsuccessful")
        }
        sqlite3_finalize(createTableStatement)
    }
}

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
    
    func insertStudentDataIntoTable(newId : Int, newName : String){
        let insertTableQueryString = "INSERT INTO Student(id,name) VALUES(?,?);"
        var insertStatement : OpaquePointer? = nil
        if sqlite3_prepare(db,
                           insertTableQueryString,
                           -1,
                           &insertStatement,
                           nil) == SQLITE_OK{
            print("Statement preparation is successful")
            sqlite3_bind_int(insertStatement, 1, Int32(newId))
            sqlite3_bind_text(insertStatement,
                              2,
                              (newName as NSString).utf8String,
                              -1,
                              nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("insert successful")
            } else {
                print("insert unsuccessful")
            }
        } else {
            print("Statement preparation is unsuccessful")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func deleteStatement(newId : Int){
        let deleteQueryString = "DELETE FROM Student where id = ?;"
        var deleteStatement : OpaquePointer?
        if sqlite3_prepare(db,
                           deleteQueryString, 
                           -1,
                           &deleteStatement,
                           nil) == SQLITE_OK {
            
            sqlite3_bind_int(deleteStatement, 1, Int32(newId))
            print("Delete Statement is prepared")
        } else {
            print("Delete Statement is not prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func readStudentData()->[Student]{
        var students : [Student] = []
        let retriveQueryString = "SELECT * FROM Student;"
        var retriveStatement : OpaquePointer?
        if sqlite3_prepare(db,
                           retriveQueryString,
                           -1,
                           &retriveStatement,
                           nil) == SQLITE_OK{
            print("retrive data statement prepared successfully")
            
            while sqlite3_step(retriveStatement) == SQLITE_ROW{
               let extractedStudentId = sqlite3_column_int(retriveStatement, 0)
               let extractedStudentName = String(describing: String(cString: sqlite3_column_text(retriveStatement, 1)))
                
            }
        } else {
            print("retrive statement preparation failed")
        }
        sqlite3_finalize(retriveStatement)
    }
}

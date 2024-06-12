//
//  ViewController.swift
//  10_04_24_SqliteDemo
//
//  Created by Vishal Jagtap on 10/06/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var dbHelper = DBHelper()
        dbHelper.insertStudentDataIntoTable(newId: <#T##Int#>, newName: <#T##String#>)
        dbHelper.deleteStatement(newId: <#T##Int#>)
        
        
    }
}

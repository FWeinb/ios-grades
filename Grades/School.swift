//
//  School.swift
//  grades
//
//  Created by Sven Hesse on 10.02.16.
//  Copyright © 2016 Sven Hesse. All rights reserved.
//

import Foundation

/*
 * Type names for row indices.
 */
enum GradelistIndexKey: String {
    case term = "term"
    case cp = "cp"
    case lecture = "lecture"
    case grade = "grade"
    case state = "state"
}

/*
 * Schhol object holding configuration data.
 */
class School: CustomStringConvertible {
    var key: String
    var name: String
    var order: Character
    var url: String
    var urlTrail: String
    var urlListTrail: String
    var loginParameters: (String, String)
    var gradelistClasses: [String]
    
    var gradelistIndices: [GradelistIndexKey: Int]
    
    init(
        key: String,
        name: String,
        order: Character,
        url: String,
        urlTrail: String = "/qisserver/rds?state=",
        urlListTrail: String = "%2Cstgnr%3D1&expand=0&asi=",
        loginParameters: (String, String) = ("asdf", "fdsa"),
        gradelistClasses: [String] = ["qis_records", "tabelle1_alignright", "tabelle1_alignleft"],
        gradelistIndices: [GradelistIndexKey: Int] = [GradelistIndexKey: Int]()
        ) {
        self.key = key
        self.name = name
        self.order = order
        self.url = url
        self.urlTrail = urlTrail
        self.urlListTrail = urlListTrail
        self.loginParameters = loginParameters
        self.gradelistClasses = gradelistClasses
        self.gradelistIndices = gradelistIndices
    }
    
    convenience init() {
        self.init(key: "", name: "",  order: "-", url: "")
    }
    
    // to string
    var description: String {
        return "\(key): \(name) (\(url))"
    }
    
}

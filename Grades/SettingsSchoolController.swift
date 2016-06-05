//
//  SettingsSchoolController.swift
//  grades
//
//  Created by Sven Hesse on 26.06.15.
//  Copyright (c) 2015 Sven Hesse. All rights reserved.
//

import Foundation
import UIKit

/*
 * Controller for school selection.
 */
class SettingsSchoolController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // outlets
    
    @IBOutlet weak var table: UITableView!

    // variables
    
    var alphabet = [String]()
    var orderedSchools: [[School]] = [[School]]()
    
    // table functions
    
    func tableView(tableView : UITableView, titleForHeaderInSection section: Int) -> String? {
        return alphabet[section]
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return orderedSchools.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedSchools[section].count
    }

    /*
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return alphabet
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return index
    }
    */

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "schoolCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) 
        
        cell.textLabel!.textColor = UIColor.blackColor()
        cell.textLabel!.text = "\(orderedSchools[indexPath.section][indexPath.row].name)"
       
        // show checkmark if school is selected school
        if (orderedSchools[indexPath.section][indexPath.row].name == school.name) {
            cell.accessoryType = .Checkmark
        }
        else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // reset values when changing school
        if (orderedSchools[indexPath.section][indexPath.row].name != school.name) {
            grades = []
            username = ""
            password = ""
            
            NSUserDefaults.standardUserDefaults().setValue(username, forKey: "username")
            try! keychain.set(password, key: "password")
        }
        
        school = orderedSchools[indexPath.section][indexPath.row]
        NSUserDefaults.standardUserDefaults().setValue(school.key, forKey: "key")

        // reset switch settings as well
        settings[Setting.IncludeDetails.rawValue] = false
        settings[Setting.ShowDetailSwitch.rawValue] = false
        NSUserDefaults.standardUserDefaults().setObject(settings, forKey: "settings")
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    // view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // order schools per first character
        setSchoolsForTable()
        
        self.table.delegate = self
        self.table.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // helper
    
    private func setSchoolsForTable() {
        var previousOrder: Character = "-"
        
        // create alphabet from schools as sections
        for s in schools {
            if (s.order != previousOrder) {
                orderedSchools.append([s])
                alphabet.append("\(s.order)")
            }
            else {
                orderedSchools[orderedSchools.count-1].append(s)
            }
            previousOrder = s.order
        }
    }

}

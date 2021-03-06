//
//  GradesScoreController.swift
//  grades
//
//  Created by Sven Hesse on 26.07.15.
//  Copyright (c) 2015 Sven Hesse. All rights reserved.
//

import Foundation
import UIKit

/*
 * Controller for detail view showing score list.
 */
class GradesDetailController: UITableViewController {

    // variables
    
    internal var grade: Grade!
    
    // view functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateView()
    }
    
    // helper
    
    fileprivate func updateView() {
        self.title = grade.lecture
    }
}

// MARK - table

extension GradesDetailController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return grade.details!.scores.count == 0 ? 1 : 2
    }
    
    override func tableView(_ tableView : UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Notenspiegel"
        }
        else if (section == 1) {
            return "Details"
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return grade.details!.scores.count == 0 ? 1 : grade.details!.scores.count
        }
        else if (section == 1) {
            return 2
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let entry = grade.details!
        let scores = entry.scores[(indexPath as NSIndexPath).row]
        
        let identifier = "detailCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DetailTableViewCell
        
        if ((indexPath as NSIndexPath).section == 0) {
            if (entry.scores.count == 0 && entry.scoresStatus == .notEnoughParticipants) {
                cell.textLabel!.text = "Zu wenige Leistungen für Notenspiegel vorliegend."
            }
            else if (entry.scores.count == 0) {
                cell.textLabel!.text = "Notenspiegel konnte nicht geladen werden."
            }
            else {
                cell.descriptionLabel.text = "\(scores.text)"
                
                if (scores.isOwn) {
                    cell.descriptionLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
                }
                
                cell.scoreLabel.text  = "\(scores.amount)"
            }
        }
        else if ((indexPath as NSIndexPath).section == 1) {
            if ((indexPath as NSIndexPath).row == 0 && entry.participants != 0) {
                cell.descriptionLabel.text = "Teilnehmer"
                cell.scoreLabel.text  = "\(entry.participants)"
            }
            else if ((indexPath as NSIndexPath).row == 1 && entry.average != "") {
                cell.descriptionLabel.text = "Durchschnittsnote"
                cell.scoreLabel.text  = "\(entry.average)"
            }
        }
        
        return cell
    }
}

//
//  CompaniesTableViewCell.swift
//  ASAP
//
//  Created by Sriram Velaga on 27/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class CompaniesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    var companyInfoDic: Dictionary? = [String: String]()
    
    
    func updateCellAtIndexPath() {
        
        self.companyNameLabel?.text = companyInfoDic?["name"]
    }
}

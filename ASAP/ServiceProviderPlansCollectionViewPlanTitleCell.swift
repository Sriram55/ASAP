//
//  ServiceProviderPlansCollectionViewPlanTitleCell.swift
//  ASAP
//
//  Created by Sriram Velaga on 28/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class ServiceProviderPlansCollectionViewPlanTitleCell: UICollectionViewCell {
    
    @IBOutlet weak var selectPlanButton: UIButton!
    
    @IBOutlet weak var planTypeLabel: UILabel!
    @IBOutlet weak var planNameLabel: UILabel!
    
    @IBOutlet weak var rightSideSeparatorView: UIView!
    @IBOutlet weak var joinPlanLabel: UILabel!
    
    var planInfoDic: Dictionary? = [String: AnyObject]()

    func updateRowAtIndexpath(_indexpath: IndexPath) {
        
        planNameLabel.text = planInfoDic?["plan_name"] as? String
        
    }
    
}

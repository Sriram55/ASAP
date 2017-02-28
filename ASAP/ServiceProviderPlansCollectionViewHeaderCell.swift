//
//  ServiceProviderPlansCollectionViewHeaderCell.swift
//  ASAP
//
//  Created by Sriram Velaga on 28/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class ServiceProviderPlansCollectionViewHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var headerNameLabel: UILabel!
    @IBOutlet weak var rightSideSeparatorView: UIView!

    var headerInfoDic: Dictionary? = [String: AnyObject]()

    func updateRowAtIndexpath(_indexpath: IndexPath) {
        
        headerNameLabel.text = headerInfoDic?["plan_name"] as? String
        
    }
    
}

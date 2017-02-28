//
//  ServiceProviderPlansCollectionViewCell.swift
//  ASAP
//
//  Created by Sriram Velaga on 28/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class ServiceProviderPlansCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var planIndicatorImageView: UIImageView!
    
    @IBOutlet weak var rightSideSeparatorView: UIView!
    @IBOutlet weak var planDescLabel: UILabel!
    
    var planInfoDic: Dictionary? = [String: AnyObject]()
    var headerInfoDic: Dictionary? = [String: AnyObject]()

    func updateRowAtIndexpath(_indexpath: IndexPath) {
        
        switch _indexpath.item % 5 {
        case 1:
            planDescLabel?.text = planInfoDic?["plan"]?["mins"] as? String
            break
        case 2:
            planDescLabel?.text = planInfoDic?["plan"]?["int"] as? String

            break
        case 3:
            planDescLabel?.text = planInfoDic?["plan"]?["roa"] as? String

            break
        case 4:
            planDescLabel?.text = planInfoDic?["plan"]?["sms"] as? String

            break
        
        default:
            break
        }
        
        planIndicatorImageView?.af_setImage(withURL: URL(string: (headerInfoDic?["icon"])! as! String)! as URL,
                                              placeholderImage: nil,
                                              filter: nil, progress: { (Progress) in
                                                
        }, imageTransition: .noTransition,
           runImageTransitionIfCached: true,
           completion: { (_result) in
            self.planIndicatorImageView?.image = _result.value
        })

        
        
    }
    
    
}

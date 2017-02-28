//
//  SelectLocationCollectionViewCell.swift
//  ASAP
//
//  Created by Sriram Velaga on 25/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class SelectLocationCollectionViewCell: UICollectionViewCell {
    
    var menuInfoDic: Dictionary? = [String: String]()
    
    @IBOutlet weak var locationImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        //        bgView?.layer.cornerRadius = 5.0
    }
    
    func updateItemAtIndexPath(_ indexPath: IndexPath) {
        
        titleLabel?.text = menuInfoDic?["name"]
        
        locationImageView?.af_setImage(withURL: URL(string: (menuInfoDic?["image"])!)! as URL,
                                   placeholderImage: nil,
                                   filter: nil, progress: { (Progress) in
                                    
        }, imageTransition: .noTransition,
           runImageTransitionIfCached: true,
           completion: { (_result) in
            self.locationImageView?.image = _result.value
        })
        
        
    }
    
}

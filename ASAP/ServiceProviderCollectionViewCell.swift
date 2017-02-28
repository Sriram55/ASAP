//
//  ServiceProviderCollectionViewCell.swift
//  ASAP
//
//  Created by Sriram Velaga on 26/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class ServiceProviderCollectionViewCell : UICollectionViewCell
{
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var serviceProviderImageView: UIImageView!
    
    var serviceProviderInfoDic: Dictionary? = [String: String]()
    
    override func awakeFromNib() {
        bgView?.layer.cornerRadius = 5.0
        bgView?.layer.borderWidth = 2.0
        bgView?.layer.borderColor = UIColor.gray.cgColor
    }
    
    func updateItemAtIndexPath(_ indexPath: IndexPath) {
        
        serviceProviderImageView?.af_setImage(withURL: URL(string: (serviceProviderInfoDic?["image"])!)! as URL,
                                       placeholderImage: nil,
                                       filter: nil, progress: { (Progress) in
                                        
        }, imageTransition: .noTransition,
           runImageTransitionIfCached: true,
           completion: { (_result) in
            self.serviceProviderImageView?.image = _result.value
        })
        
        
    }
    
}

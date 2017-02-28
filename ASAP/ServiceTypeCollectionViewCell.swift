//
//  ServiceTypeCollectionViewCell.swift
//  ASAP
//
//  Created by Sriram Velaga on 25/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class ServiceTypeCollectionViewCell: UICollectionViewCell {
    
    var menuInfoDic: Dictionary? = [String: AnyObject]()
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageViewHorizontalCenterConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
//        bgView?.layer.cornerRadius = 5.0
    }
    
    func updateItemAtIndexPath(_ indexPath: IndexPath) {
        
        titleLabel?.text = menuInfoDic?["name"] as! String?
        
        logoImageView?.af_setImage(withURL: URL(string: (menuInfoDic?["icon"])! as! String)! as URL,
                                   placeholderImage: nil,
                                   filter: nil, progress: { (Progress) in
                                    
        }, imageTransition: .noTransition,
           runImageTransitionIfCached: true,
           completion: { (_result) in
            self.logoImageView?.image = _result.value
        })
        
        if let outcome = menuInfoDic?["color_code"] as? NSDictionary {
            bgView?.backgroundColor = UIColor(red: CGFloat(NumberFormatter().number(from: outcome["red"] as! String)!) / 255.0, green: CGFloat(NumberFormatter().number(from: outcome["green"] as! String)!) / 255.0, blue: CGFloat(NumberFormatter().number(from: outcome["blue"] as! String)!) / 255.0, alpha: CGFloat(NumberFormatter().number(from: outcome["alpha"] as! String)!))
        } else {
            bgView?.backgroundColor = UIColor().asapThemeColor()
        }

        

        
        imageViewHorizontalCenterConstraint.constant = -(self.frame.size.height - logoImageView.frame.size.height - titleLabel.frame.size.height - 5)/2
        
    }
    
}

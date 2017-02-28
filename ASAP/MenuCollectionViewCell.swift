//
//  MenuCollectionViewCell.swift
//  ASAP
//
//  Created by Sriram Velaga on 25/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    var menuInfoDic: Dictionary? = [String: AnyObject]()
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageViewHorizontalCenterConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        bgView?.layer.cornerRadius = 5.0
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
        
        bgView?.backgroundColor = UIColor(red: CGFloat(NumberFormatter().number(from: menuInfoDic?["color_code"]?["red"] as! String)!) / 255.0, green: CGFloat(NumberFormatter().number(from: menuInfoDic?["color_code"]?["green"] as! String)!) / 255.0, blue: CGFloat(NumberFormatter().number(from: menuInfoDic?["color_code"]?["blue"] as! String)!) / 255.0, alpha: CGFloat(NumberFormatter().number(from: menuInfoDic?["color_code"]?["alpha"] as! String)!))
            
        imageViewHorizontalCenterConstraint.constant = -(self.frame.size.height - logoImageView.frame.size.height - titleLabel.frame.size.height - 5)/2

    }
    
}

//
//  BannerCollectionViewCell.swift
//  ASAP
//
//  Created by Sriram Velaga on 25/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class BannersCollectionViewCell: UICollectionViewCell {
    
    var bannerInfoDic: Dictionary? = [String: String]()
    @IBOutlet weak var bannersImageView: UIImageView!
    
    @IBOutlet weak var bannerActionBtn: UIButton!
    @IBOutlet weak var bannerDescLabel: UILabel!
    
    override func awakeFromNib() {
        bannerActionBtn?.layer.borderColor = UIColor().bannersTextColor().cgColor
        bannerActionBtn?.layer.borderWidth = 2.0
        bannerActionBtn?.layer.cornerRadius = 5.0
    }
    
    func updateItemAtIndexPath(_ indexPath: IndexPath) {
        
        bannerDescLabel?.text = bannerInfoDic?["short_description"]
        bannerActionBtn?.setTitle("   " + (bannerInfoDic?["banner_button"])! + "   " ,for: .normal)
        
        
        bannersImageView?.af_setImage(withURL: URL(string: (bannerInfoDic?["banner"])!)! as URL,
                                      placeholderImage: nil,
                                      filter: nil, progress: { (Progress) in
                                        
        }, imageTransition: .noTransition,
           runImageTransitionIfCached: true,
           completion: { (_result) in
            self.bannersImageView?.image = _result.value
        })
    }
    
    @IBAction func bannerTapped(_ sender: Any) {
        
        
    }
    
    
    
}

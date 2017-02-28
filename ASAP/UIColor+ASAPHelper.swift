//
//  UIColor+ASAPHelper.swift
//  ASAP
//
//  Created by Sriram Velaga on 13/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    func asapThemeColor() -> UIColor {
        return UIColor.init(colorLiteralRed: 53.0/255.0, green: 86.0/255.0, blue: 174.0/255.0, alpha: 1.0)
    }
    
    func selectionIndicatorNotSelectedColor() -> UIColor {
        return UIColor.init(colorLiteralRed: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    }
    
    func selectionIndicatorSelectedColor() -> UIColor {
        return UIColor.init(colorLiteralRed: 27.0/255.0, green: 55.0/255.0, blue: 129.0/255.0, alpha: 1.0)
    }
    
    func bannersTextColor() -> UIColor {
        return UIColor.init(colorLiteralRed: 7.0/255.0, green: 66.0/255.0, blue: 95.0/255.0, alpha: 1.0)
    }
    
}

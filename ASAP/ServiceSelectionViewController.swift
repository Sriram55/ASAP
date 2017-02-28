//
//  ServiceSelectionViewController.swift
//  ASAP
//
//  Created by Sriram Velaga on 25/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

let KServiceTypeCollectionViewCellIdentifier = "ServiceTypeCollectionViewCellIdentifier"


class ServiceSelectionViewController: UIViewController {
    
    var bannersDataArray: Array? = [Dictionary<String, String>]()
    var menusDataArray: Array? = [Dictionary<String, AnyObject>]()
    
    @IBOutlet weak var bannersPageControl: UIPageControl!
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var menusCollectionView: UICollectionView!
    
    // MARK: View LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.prepareView()
        self.getMenusWithBanners()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private API
    
    func prepareView() {
        
        self.bannersCollectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: KBannersCollectionViewCellIdentifier)
        self.menusCollectionView.register(UINib(nibName: "ServiceTypeCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: KServiceTypeCollectionViewCellIdentifier)
        
    }
    
    func getMenusWithBanners() {
        
        ASAPHttpClinetManager.sharedInstance.getMenusWithBanners(["menu_id": "1"], success: { (_result) in
            
            if _result["result"]["status_code"] == "200" {
                print("------", _result)
                self.bannersDataArray = _result["result"]["data"]["info"]["banners"].arrayObject as! Array<[String : String]>?
                self.bannersPageControl.numberOfPages = (self.bannersDataArray?.count)!
                self.menusDataArray = _result["result"]["data"]["info"]["menus"].arrayObject as! Array<[String : AnyObject]>?
                self.bannersCollectionView.reloadData()
                self.menusCollectionView.reloadData()
                
            }else {
                
                let alert = UIAlertController(title: "Error", message: _result["result"]["message"].string!, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
            
        }) { (Error) in
            print("Banners data", Error)
        }
        
        
    }
    // MARK : IBAction Methods
    
    
    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        
        let scrollIndex: IndexPath? = IndexPath(row: sender.currentPage, section: 0)
        self.bannersCollectionView.scrollToItem(at: scrollIndex!, at: .centeredHorizontally, animated: true)
    }
    
}


extension ServiceSelectionViewController : UICollectionViewDataSource {
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case bannersCollectionView:
            return (self.bannersDataArray?.isEmpty == false) ? (self.bannersDataArray?.count)! : 0
            
        case menusCollectionView:
            return (self.menusDataArray?.isEmpty == false) ? (self.menusDataArray?.count)! : 0
        default:
            return 0
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case bannersCollectionView:
            let bannersCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: KBannersCollectionViewCellIdentifier, for: indexPath) as! BannersCollectionViewCell
            bannersCollectionViewCell.bannerInfoDic = self.bannersDataArray?[indexPath.item]
            bannersCollectionViewCell.updateItemAtIndexPath(indexPath)
            return bannersCollectionViewCell
            
        case menusCollectionView:
            
            let menuCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: KServiceTypeCollectionViewCellIdentifier, for: indexPath) as! ServiceTypeCollectionViewCell
            menuCollectionViewCell.menuInfoDic = ((self.menusDataArray?[indexPath.item])! as Dictionary<String, AnyObject>)
            menuCollectionViewCell.updateItemAtIndexPath(indexPath)
            return menuCollectionViewCell
            
        default:
            
            let defaultCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath)
            return defaultCollectionViewCell
            
        }
        
    }
    
}

extension ServiceSelectionViewController : UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectLocationViewController = self.storyboard!.instantiateViewController(withIdentifier: "SelectLocationViewController") as! SelectLocationViewController
        self.navigationController?.pushViewController(selectLocationViewController, animated: true)
    }

    
}

extension ServiceSelectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case bannersCollectionView:
            
            return CGSize(width: self.view.frame.size.width, height: self.bannersCollectionView.frame.size.height)
            
        case menusCollectionView:
            
            return CGSize(width: self.view.frame.size.width/2 - 17, height: 120)
            
        default:
            return CGSize.zero
        }
    }
}


extension ServiceSelectionViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView.tag == 10 {
            let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
            if let indexPath = bannersCollectionView.indexPathForItem(at: center) {
                self.bannersPageControl.currentPage = indexPath.item
            }
        }
    }
}

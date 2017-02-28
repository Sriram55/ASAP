//
//  ServiceProvidersPlansViewController.swift
//  ASAP
//
//  Created by Sriram Velaga on 27/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

let KServiceProviderPlansCollectionViewPlanTitleCellIdentifier = "ServiceProviderPlansCollectionViewPlanTitleCellIdentifier"
let KServiceProviderPlansCollectionViewCellIdentifier = "ServiceProviderPlansCollectionViewCellIdentifier"
let KServiceProviderPlansCollectionViewHeaderCellIdentifier = "ServiceProviderPlansCollectionViewHeaderCellIdentifier"
class ServiceProvidersPlansViewController : UIViewController {
    
    // MARK: View LifeCycle Methods
    
    @IBOutlet weak var serviceProviderImageView: UIImageView!
    @IBOutlet weak var serviceProviderPlansCollectionView: UICollectionView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var planSelectionSegmentedControl: UISegmentedControl!
    
    var headersDataArray: Array? = [Dictionary<String, AnyObject>]()
    var topFivePlansDataArray: Array? = [Dictionary<String, AnyObject>]()
    var allPlansDataArray: Array? = [Dictionary<String, AnyObject>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.getPlansForServiceProvider()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private API
    
    func prepareView() {
        
        self.serviceProviderPlansCollectionView.register(UINib(nibName: "ServiceProviderPlansCollectionViewPlanTitleCell", bundle:nil), forCellWithReuseIdentifier: KServiceProviderPlansCollectionViewPlanTitleCellIdentifier)
        self.serviceProviderPlansCollectionView.register(UINib(nibName: "ServiceProviderPlansCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: KServiceProviderPlansCollectionViewCellIdentifier)
        
    }
    
    func getPlansForServiceProvider() {
        
       let parameters = ["location_id":"1", "company_id":"1", "service_provider_id":"1", "category_id":"0"]
        
        ASAPHttpClinetManager.sharedInstance.getServiceProvidersPlans(parameters, success: { (_result) in
            
            if _result["result"]["status_code"] == "200" {
                print("------", _result)
                self.headersDataArray = _result["result"]["data"]["info"]["headers"].arrayObject as! Array<[String : AnyObject]>?
                self.topFivePlansDataArray = _result["result"]["data"]["info"]["top5"].arrayObject as! Array<[String : AnyObject]>?
                self.allPlansDataArray = _result["result"]["data"]["info"]["all_plans"].arrayObject as! Array<[String : AnyObject]>?
                self.serviceProviderPlansCollectionView.reloadData()
                
//                self.serviceProvidersDataArray = _result["result"]["data"]["info"].arrayObject as! Array<[String : String]>?
//                self.postPaidNewConnectionCollectionView.reloadData()
//                self.currentNetworkCollectionView.reloadData()
//                self.changeToNetworkCollectionView.reloadData()
//                self.prepaidToPostPaidCollectionView.reloadData()
                
            }else {
                
                let alert = UIAlertController(title: "Error", message: _result["result"]["message"].string!, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }) { (Error) in
            
        }
        
    }
    
}


extension ServiceProvidersPlansViewController : UICollectionViewDataSource {
    @available(iOS 6.0, *)
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0: return ((self.headersDataArray?.isEmpty)! == false) ? (self.headersDataArray?.count)! + 1 : 0
        
        case 1:
            switch self.planSelectionSegmentedControl.selectedSegmentIndex {
            case 0: return ((self.topFivePlansDataArray?.isEmpty)! == false) ? (self.topFivePlansDataArray?.count)! * 5 : 0
                
            case 1: return (self.allPlansDataArray?.isEmpty == false) ? (self.allPlansDataArray?.count)! * 5 : 0
                
            default: return 0
                
            }
            
        default: return 0
            
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            
            let serviceProviderPlansCollectionViewHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: KServiceProviderPlansCollectionViewHeaderCellIdentifier, for: indexPath) as! ServiceProviderPlansCollectionViewHeaderCell
            serviceProviderPlansCollectionViewHeaderCell.headerInfoDic = (indexPath.item == 0) ? (["plan_name" : "Plans" as AnyObject]) : self.headersDataArray?[indexPath.item - 1];
            serviceProviderPlansCollectionViewHeaderCell.updateRowAtIndexpath(_indexpath: indexPath)
            return serviceProviderPlansCollectionViewHeaderCell
            
        case 1:
            
            let requiredIndex =  (indexPath.item / 5)
            
            if indexPath.item % 5 == 0 {
                
                let serviceProviderPlansCollectionViewPlanTitleCell = collectionView.dequeueReusableCell(withReuseIdentifier: KServiceProviderPlansCollectionViewPlanTitleCellIdentifier, for: indexPath) as! ServiceProviderPlansCollectionViewPlanTitleCell
                serviceProviderPlansCollectionViewPlanTitleCell.planInfoDic = (self.planSelectionSegmentedControl.selectedSegmentIndex == 0) ? self.topFivePlansDataArray?[requiredIndex] : self.allPlansDataArray?[requiredIndex]
                serviceProviderPlansCollectionViewPlanTitleCell.updateRowAtIndexpath(_indexpath: indexPath)
                return serviceProviderPlansCollectionViewPlanTitleCell
                
            } else {
                
                let serviceProviderPlansCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: KServiceProviderPlansCollectionViewCellIdentifier, for: indexPath) as! ServiceProviderPlansCollectionViewCell
                    serviceProviderPlansCollectionViewCell.planInfoDic = (self.planSelectionSegmentedControl.selectedSegmentIndex == 0) ? self.topFivePlansDataArray?[requiredIndex] : self.allPlansDataArray?[requiredIndex]
                serviceProviderPlansCollectionViewCell.headerInfoDic = self.headersDataArray?[(indexPath.item % 5) - 1]
                serviceProviderPlansCollectionViewCell.updateRowAtIndexpath(_indexpath: indexPath)
                return serviceProviderPlansCollectionViewCell
            }
            
        default:
            let defaultCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath)
            return defaultCollectionViewCell
        }
        
    }
    
}

extension ServiceProvidersPlansViewController : UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        let selectServiceProviderViewController = self.storyboard!.instantiateViewController(withIdentifier: "SelectServiceProvideViewController") as! SelectServiceProvideViewController
//        self.navigationController?.pushViewController(selectServiceProviderViewController, animated: true)
//    }
    
    
    
}


extension ServiceProvidersPlansViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0: return CGSize(width: self.view.frame.size.width/5, height: 50)
            
        case 1: return CGSize(width: self.view.frame.size.width/5, height: self.view.frame.size.width/5)
            
        default: return CGSize.zero
            
        }
    }
}

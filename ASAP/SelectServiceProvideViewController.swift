//
//  SelectServiceProvideViewController.swift
//  ASAP
//
//  Created by Sriram Velaga on 26/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

let KServiceProviderCollectionViewCellIdentifier = "ServiceProviderCollectionViewCellIdentifier"

protocol SelectServiceProvideViewControllerProtocol : class {
    
    func updateCompanyTitle(_ companyInfo: Dictionary<String, String>?)
}

class SelectServiceProvideViewController: UIViewController {
    
    var serviceProvidersDataArray: Array? = [Dictionary<String, String>]()
    var companiesDataArray: Array? = [Dictionary<String, String>]()

    
    let segmentedControl = HMSegmentedControl(items: ["Postpaid New Connection", "Postpaid MNP", "Prepaid to Postpaid"])

    // MARK: Postpaid new connection properties
    @IBOutlet weak var postPaidNewConnectionView: UIView!

    @IBOutlet weak var postPaidNewConnectionCollectionView: UICollectionView!
    
    @IBOutlet weak var selectedCompanyNameLabel: UILabel!

    // MARK: Postpaid MNP View properties
    
    @IBOutlet weak var postpaidMNPView: UIView!
    
    @IBOutlet weak var postPaidToMNPSelectedCompanyLabel: UILabel!
    @IBOutlet weak var changeToNetworkCollectionView: UICollectionView!
    @IBOutlet weak var currentNetworkCollectionView: UICollectionView!
    
    @IBOutlet weak var upcCodeTextField: UITextField!
    // MARK: Prepaid to Postpaid properties
    @IBOutlet weak var prepaidToPostpaidView: UIView!
    @IBOutlet weak var prepaidToPostpaidSelectedCompanyLabel: UILabel!

    @IBOutlet weak var prepaidToPostPaidCollectionView: UICollectionView!
    
    
    
    
    // MARK: View LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.prepareView()
        self.preparePostPaidNewConnectionView()
        self.getTelecomServiceProviders()
        self.getCompanies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Private API
    
    func prepareView() {
        self.view.addSubview(segmentedControl)

        segmentedControl.backgroundColor = UIColor().asapThemeColor()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectionIndicatorPosition = .bottom
        segmentedControl.selectionIndicatorColor = #colorLiteral(red: 0.1142767668, green: 0.3181744218, blue: 0.4912756383, alpha: 1)
        
        segmentedControl.titleTextAttributes = [
            NSForegroundColorAttributeName : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            NSFontAttributeName : UIFont(name: "MyriadPro-Regular", size: 18.0)!

        ]
        
        segmentedControl.selectedTitleTextAttributes = [
            NSForegroundColorAttributeName : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            NSFontAttributeName : UIFont(name: "MyriadPro-Regular", size: 18.0)!
        ]
        
        segmentedControl.indexChangedHandler = { index in
            
            switch index {
                
            case 0:
                
                self.postPaidNewConnectionView.isHidden = false
                self.postpaidMNPView.isHidden = true
                self.prepaidToPostpaidView.isHidden = true
                
                break
                
                
            case 1:
            
                self.postPaidNewConnectionView.isHidden = true
                self.postpaidMNPView.isHidden = false
                self.prepaidToPostpaidView.isHidden = true
                
                break
                
            case 2:
                
                self.postPaidNewConnectionView.isHidden = true
                self.postpaidMNPView.isHidden = true
                self.prepaidToPostpaidView.isHidden = false
                
                break
                
            default:
                break
            }
            
        }
        
        NSLayoutConstraint.activate(
            [segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor),
             segmentedControl.heightAnchor.constraint(equalToConstant: 60),
             segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor),
             segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 64)]
        )
    }
    
    func getTelecomServiceProviders() {
                
        ASAPHttpClinetManager.sharedInstance.getTelecomServiceProviders([:], success: { (_result) in
            
            if _result["result"]["status_code"] == "200" {
                print("------", _result)
                self.serviceProvidersDataArray = _result["result"]["data"]["info"].arrayObject as! Array<[String : String]>?
                self.postPaidNewConnectionCollectionView.reloadData()
                self.currentNetworkCollectionView.reloadData()
                self.changeToNetworkCollectionView.reloadData()
                self.prepaidToPostPaidCollectionView.reloadData()
                
            }else {
                
                let alert = UIAlertController(title: "Error", message: _result["result"]["message"].string!, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }) { (Error) in
            
        }
        
    }
    
    func getCompanies() {
        
        let parameters: Dictionary? = ["locations_id" : "3"]
        ASAPHttpClinetManager.sharedInstance.getCompanies(parameters!, success: { (_result) in
            print(" Companies are ------", _result)
            self.companiesDataArray = _result["result"]["data"]["info"].arrayObject as! Array<[String : String]>?
            
        }) { (Error) in
            print(" Error  ------", Error)

        }
        
    }
    
    func preparePostPaidNewConnectionView() {
        
        postPaidNewConnectionCollectionView.register(UINib(nibName: "ServiceProviderCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: KServiceProviderCollectionViewCellIdentifier)
        prepaidToPostPaidCollectionView.register(UINib(nibName: "ServiceProviderCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: KServiceProviderCollectionViewCellIdentifier)
        currentNetworkCollectionView.register(UINib(nibName: "ServiceProviderCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: KServiceProviderCollectionViewCellIdentifier)
        changeToNetworkCollectionView.register(UINib(nibName: "ServiceProviderCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: KServiceProviderCollectionViewCellIdentifier)

    }
    
    //MARK: IBAction Methods
    
    @IBAction func showListOfCorporateCompanies(_ sender: UIButton) {
        
        let companiesListViewController = self.storyboard!.instantiateViewController(withIdentifier: "CompaniesListViewController") as! CompaniesListViewController
        addChildViewController(companiesListViewController)
        companiesListViewController.selectServiceProviderViewControllerDelegate = self
        companiesListViewController.compainesDataArray = self.companiesDataArray
        
        companiesListViewController.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)

        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            companiesListViewController.view.frame = self.view.frame

        }) { (Bool) in
            
        }
        
        self.view.addSubview(companiesListViewController.view)
        companiesListViewController.didMove(toParentViewController: self)
    }
    
    @IBAction func proceedToPlans(_ sender: UIButton) {
        
        let serviceProvidersPlansViewController = self.storyboard!.instantiateViewController(withIdentifier: "ServiceProvidersPlansViewController") as! ServiceProvidersPlansViewController

        self.navigationController?.pushViewController(serviceProvidersPlansViewController, animated: true)
        
    }
}

extension SelectServiceProvideViewController: UICollectionViewDelegate {
    
}


extension SelectServiceProvideViewController: UICollectionViewDataSource {
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case postPaidNewConnectionCollectionView, prepaidToPostPaidCollectionView, currentNetworkCollectionView, changeToNetworkCollectionView:
            return (self.serviceProvidersDataArray?.isEmpty == false) ? (self.serviceProvidersDataArray?.count)! : 0
            
        default:
            return 0
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case postPaidNewConnectionCollectionView, prepaidToPostPaidCollectionView, currentNetworkCollectionView, changeToNetworkCollectionView:
            let serviceProviderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: KServiceProviderCollectionViewCellIdentifier, for: indexPath) as! ServiceProviderCollectionViewCell
            serviceProviderCollectionViewCell.serviceProviderInfoDic = self.serviceProvidersDataArray?[indexPath.item]
            serviceProviderCollectionViewCell.updateItemAtIndexPath(indexPath)
            return serviceProviderCollectionViewCell
            
        default:
            
            let defaultCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath)
            return defaultCollectionViewCell
            
        }
        
    }
    
}


extension SelectServiceProvideViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case postPaidNewConnectionCollectionView, prepaidToPostPaidCollectionView, currentNetworkCollectionView, changeToNetworkCollectionView:
            
            return CGSize(width: 90, height: 90)
            
        default:
            return CGSize.zero
        }
    }
}

extension SelectServiceProvideViewController: SelectServiceProvideViewControllerProtocol {
    internal func updateCompanyTitle(_ companyInfo: Dictionary<String, String>?) {
        
        self.selectedCompanyNameLabel?.text = companyInfo?["name"]
        self.postPaidToMNPSelectedCompanyLabel?.text = companyInfo?["name"]
        self.prepaidToPostpaidSelectedCompanyLabel?.text = companyInfo?["name"]
        
        
        
    }

    
}


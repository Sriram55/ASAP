//
//  CompaniesListViewController.swift
//  ASAP
//
//  Created by Sriram Velaga on 27/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

let KCompaniesListTableViewCellIdentifier = "CompaniesTableViewCellIdentifier"

class CompaniesListViewController: UIViewController {

    var compainesDataArray: Array? = [Dictionary<String, String>]()
    
    weak var selectServiceProviderViewControllerDelegate: SelectServiceProvideViewControllerProtocol?
    
    @IBOutlet weak var companiesListTableView: UITableView!
    // MARK: View LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.prepareView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Private API

    func prepareView() {
        
        self.companiesListTableView.register(UINib(nibName: "CompaniesTableViewCell", bundle:nil), forCellReuseIdentifier: KCompaniesListTableViewCellIdentifier)
    }

    //MARK : IBAction Methods
    
    @IBAction func dissmissCompaniesList(_ sender: UIButton) {
        self.willMove(toParentViewController: nil)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
        }) { (Bool) in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()

        }

        
    }
}

extension CompaniesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectServiceProviderViewControllerDelegate?.updateCompanyTitle(self.compainesDataArray?[indexPath.row])

    }
}

extension CompaniesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ((self.compainesDataArray?.isEmpty)! == false) ? (self.compainesDataArray?.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let companiesTableViewCell = tableView.dequeueReusableCell(withIdentifier: KCompaniesListTableViewCellIdentifier, for: indexPath) as! CompaniesTableViewCell
        companiesTableViewCell.companyInfoDic = self.compainesDataArray?[indexPath.row]
        companiesTableViewCell.updateCellAtIndexPath()
        return companiesTableViewCell
    }
}




//
//  SelectMobileNumberViewController.swift
//  ASAP
//
//  Created by Praveen Vinukonda on 28/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import UIKit
//SelectMobileNumberTableViewCell
class SelectMobileNumberViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var phoneNumberTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    var tempPhoneNumber : NSMutableArray?
    let phoneNumbers: [String] = ["9951461155", "0928039182", "0973182739812", "9951662772", "091298179812", "0928034539182", "034928039182", "0928034349182", "0928034339182", "0928043439182", "092834039182", "0934328039182"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "SelectMobileNumberTableViewCell"
    
    // don't forget to hook this up from the storyboard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the table view cell class and its reuse id
        
        self.phoneNumberTableView.register(UINib(nibName: "SelectMobileNumberTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        // This view controller itself will provide the delegate methods and row data for the table view.
        phoneNumberTableView.delegate = self
        phoneNumberTableView.dataSource = self
        self.getPostpaidPhoneNumbersFromServer()
    }
    
    
    
    //Get Phone Numbers Data
    
    func getPostpaidPhoneNumbersFromServer () {
        
        let parameters: Dictionary? = ["type" : "postpaid","service_providers_id":2,"locations_id":1,"companies_id":1]
        ASAPHttpClinetManager.sharedInstance.getPostPaidPhoneNumbers(parameters!, success: { (_result) in
            print(" Companies are ------", _result)
            
        }) { (Error) in
            print(" Error  ------", Error)
            
        }
        
    }

    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.phoneNumbers.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = self.phoneNumberTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! SelectMobileNumberTableViewCell!

        // set the text from the data model
        cell?.phoneNumberLabel?.text = self.phoneNumbers[indexPath.row]
        
        return cell!
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}
    extension SelectMobileNumberViewController: UITextFieldDelegate {
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            return true
            }
        
    }
    


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


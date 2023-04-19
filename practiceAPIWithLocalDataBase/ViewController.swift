//
//  ViewController.swift
//  practiceAPIWithLocalDataBase
//
//  Created by Lalaiya Sahil on 15/02/23.
//

import UIKit
import Alamofire
import FMDB

class ViewController: UIViewController {
    @IBOutlet weak var idTextfilde: UITextField!
    @IBOutlet weak var userIdTextFilde: UITextField!
    @IBOutlet weak var titleTextFilde: UITextField!
    @IBOutlet weak var bodyTextFilde: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    var arrOfUserDetils: [UserDetails] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersDetails()
    }
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        for i in arrOfUserDetils{
            let query = "INSERT INTO user values ('\(i.id))', '\(i.userId)', '\(i.name)','\(i.email)' '\(i.body)');"
            print(query)
            let dataBaseObject = FMDatabase(path: AppDelegate.databasePath)
            if dataBaseObject.open(){
                let result = dataBaseObject.executeUpdate(query, withArgumentsIn: [])
                if result == true{
                    messageLabel.text = "Data Saved"
                }else{
                    messageLabel.text = "Data Not Saved"
                }
            }
        }
    }
    
    @IBAction func updateButtonClicked(_ sender: UIButton) {
       
            let query = "UPDATE user SET id = '\(idTextfilde.text ?? "")', userId = '\(userIdTextFilde.text ?? "")', title = '\(titleTextFilde.text ?? "")' WHERE body = '\(bodyTextFilde.text ?? "")';"
            print(query)
            let dataObject = FMDatabase(path: AppDelegate.databasePath)
            if dataObject.open(){
                let result = dataObject.executeUpdate(query, withArgumentsIn: [])
                if result == true{
                    idTextfilde.text = ""
                    userIdTextFilde.text = ""
                    titleTextFilde.text = ""
                    bodyTextFilde.text = ""
                    messageLabel.text = "Data Update Successfully"
                }else{
                    messageLabel.text = "Data Not Update Successfully"
                }
            }
    }
    
    
    private func getUsersDetails(){
        AF.request("https://gorest.co.in/public/v2/comments", method: .get).responseData { response in
            debugPrint("response \(response)")
            if response.response?.statusCode == 200{
                guard let apiData = response.data else { return }
                do{
                    self.arrOfUserDetils = try JSONDecoder().decode([UserDetails].self, from: apiData)
                }catch{
                    print(error.localizedDescription)
                }
            }else{
                print("Something went wrong")
            }
        }
    }
    
}
struct UserDetails: Decodable{
    var id: Double
    var userId: Double
    var name: String
    var email: String
    var body: String
    
    private enum CodingKeys: String, CodingKey{
        case id = "id"
        case userId = "post_id"
        case name = "name"
        case email = "email"
        case body = "body"
    }
}


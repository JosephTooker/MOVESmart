//
//  MapViewController.swift
//  Sign_Reader3
//
//  Created by Joseph Tooker on 11/22/21.
//

import UIKit
import Foundation
import FirebaseFirestore

class MapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let database = Firestore.firestore()
    var data = [String]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func findCount() async {
        do {
            count = try await database.collection("agency").getDocuments().count
        } catch {
            print("error finding count")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusCell") as! BusCell
        
        database.collection("agency").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    cell.nameLabel.text = document.data()["agency_name"] as! String
                    cell.numberLabel.text = document.data()["agency_phone"] as! String
                    cell.urlLabel.text = document.data()["agency_url"] as! String

                }
            }
        }
        
        return cell
    }
    


}

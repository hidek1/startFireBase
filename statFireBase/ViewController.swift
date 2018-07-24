//
//  ViewController.swift
//  statFireBase
//
//  Created by 吉永秀和 on 2018/07/23.
//  Copyright © 2018年 吉永秀和. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {
    //下準備
    @IBOutlet weak var gbutton: UIButton!
    @IBOutlet weak var Label: UILabel!
    var ref: DocumentReference? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gbutton.isEnabled = false
    }
    @IBAction func dateIn(_ sender: Any) {
        //下準備
        let db = Firestore.firestore()
        //データ追加ドキュメントランダム
        ref = db.collection("user").addDocument(data: [
            "name": "Hide",
            "live": "Japan",
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(self.ref!.documentID)")
                }
        }
        //ドキュメント追加値指定
        let frankDocRef = db.collection("users").document("frank")
        frankDocRef.setData([
            "name": "Frank",
            "favorites": [ "food": "Pizza", "color": "Blue", "subject": "recess" ],
            "age": 12
            ])
        //2階層
        ref = db.collection("user").document("crazy").collection("sleeper").addDocument(data: ["name": "Hide"]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(self.ref!.documentID)")
                }
        }
        gbutton.isEnabled = true

    }
    
    @IBAction func getButton(_ sender: Any) {
        //下準備
        let db = Firestore.firestore()
        //値取得
        let docRef = db.collection("users").document("frank")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                self.Label.text = document.data()!["name"] as! String
            } else {
                print("Document does not exist")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  LoginManager.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 04/08/23.
//

import Foundation
import Firebase

class SignUpManager: ObservableObject{
    
    @Published var success: Bool = false
    func createUser(name: String,email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password){ [self] (result, error) in
            if error != nil{
                print(error)
            }
            let user = result?.user.uid
            addToDataBase(id: user!,name: name)
        }
    }
    
    func addToDataBase(id: String,name: String){
        let db = Firestore.firestore()
        let collection = db.collection("Users")
        collection.document(id).setData(["id":id, "Name": name,"Subscription": ""])
        self.success = true
    }
}



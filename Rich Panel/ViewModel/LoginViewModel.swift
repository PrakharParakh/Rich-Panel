//
//  LoginViewModel.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 05/08/23.
//

import Foundation
import Firebase

class LoginViewModel: ObservableObject{
    
    @Published var alreadySubscribed: Bool = false
    var data: [User] = []
    func checkSubscription(){
        let db = Firestore.firestore()
                
        let docRef = db.collection("Users")
        let query = docRef.whereField("id", isEqualTo: Auth.auth().currentUser?.uid)
                
                
        query.getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors

                if let snapshot = snapshot {
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        // Get all the documents and create Todos
                        self.data = snapshot.documents.map { d in
                            
                            if (d["Subscription"] as! String).count  > 0{
                                self.alreadySubscribed = true
                            }
                            // Create a Todo item for each document returned
                            return User(id: d["id"] as? String ?? "", name: d["name"] as? String ?? "", Subscription: d["Subscription"] as? String ?? "")
                            
                        }
                    }
                    
                    
                    
                }
            }
            else {
                return
            }
        }
    }
}

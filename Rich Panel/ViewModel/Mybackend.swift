//
//  Mybackend.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 05/08/23.
//

import Foundation
import StripePaymentSheet
import Firebase

class MyBackendModel: ObservableObject {
  let backendCheckoutUrl = URL(string: "https://glossy-outstanding-drug.glitch.me/payment-sheet")! // Your backend endpoint
  @Published var paymentSheet: PaymentSheet?
  @Published var paymentResult: PaymentSheetResult?

    func preparePaymentSheet() {
        // MARK: Fetch the PaymentIntent and Customer information from the backend
        
        var request = URLRequest(url: backendCheckoutUrl)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("hi")
        
        request.httpBody = try? JSONEncoder().encode(PaymentConfig.plan.plan)
        print("hii")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                  let customerId = json["customer"] as? String,
                  let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
                  let paymentIntentClientSecret = json["paymentIntent"] as? String,
                  let publishableKey = json["publishableKey"] as? String,
                  let self = self else {
                print("err")
                // Handle error
                return
            }
            
            // MARK: Create a PaymentSheet instance
            var configuration = PaymentSheet.Configuration()
            configuration.merchantDisplayName = "Example, Inc."
            configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            // Set `allowsDelayedPaymentMethods` to true if your business can handle payment methods
            // that complete payment after a delay, like SEPA Debit and Sofort.
            configuration.allowsDelayedPaymentMethods = true
            
            DispatchQueue.main.async {
                self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
            }
        })
        task.resume()
        
    }

    func onPaymentCompletion(result: PaymentSheetResult) {
        self.paymentResult = result
        
    }
    func updateSubscription(){
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document("\(Auth.auth().currentUser!.uid)")
                
                
        docRef.updateData(["Subscription": PaymentConfig.plan.devices.name])
            
        
    }
    
    
}

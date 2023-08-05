//
//  PaymentViewModel.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 05/08/23.
//

import Foundation

class PaymentViewModel: ObservableObject{
    
    func checkout(complection: @escaping (String?) -> Void){
        let url = URL(string: "https://glossy-outstanding-drug.glitch.me/create-payment-intent")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode("500")
        
        URLSession.shared.dataTask(with: request){data, response, error in
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else{
                complection(nil)
                return
            }
            let secret = try? JSONDecoder().decode(Payment.self,from: data)
            print(secret)
            complection(secret?.clientSecret)
            
        }.resume()
    }
}

//
//  PaymentView.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 05/08/23.
//

import SwiftUI
import Stripe
import StripePaymentSheet

struct PaymentView: View {
    var plan: Plans
    @State var paymentMethod: STPPaymentMethodParams?
    @StateObject var payMentViewModel = PaymentViewModel()
    let paymentGateway = PaymentGatewayController()
    
    var body: some View {
        VStack{
            
            VStack(alignment:.leading,spacing: 20){
                Text("Order Summary")
                    .font(.title2)
                HStack(){
                    Text("Plan Name")
                        .frame(width: 130,alignment: .leading)
                    Text(plan.devices.name)
                        .padding()
                }
                Divider()
                    .frame(height: 3)
                HStack(){
                    Text("Billing Cycle")
                        .frame(width: 130,alignment: .leading)
                    Text(plan.duration)
                        .padding()
                }
                Divider()
                    .frame(height: 3)
                HStack(){
                    Text("Plan price")
                        .frame(width: 130,alignment: .leading)
                    Text("\(plan.plan.monthlyPrice) Inr")
                        .padding()
                }
                Divider()
                    .frame(height: 3)
            }.padding(.leading)
                .padding(.bottom)
            
            VStack(alignment:.leading){
                Text("Compelete Payment")
                    .font(.title)
                Text("Enter your credit or debit card details")
                    .font(.caption)
               STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethod)
                    .padding()
                
                
                
            }.padding(.leading)
                .padding(.top)
                
            Button{
                pay()
            }label: {
                Text("Confirm Payment")
                    .foregroundColor(.white)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                            .frame(width: 150,height: 40)
                    }
            }
        }
        .onAppear{
            checkout { secret in
                PaymentConfig.shared.paymentIntentClientSecret = secret
            }
        }
    }
    
    func checkout(complection: @escaping (String?) -> Void){
        let url = URL(string: "https://glossy-outstanding-drug.glitch.me/create-payment-intent")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(plan.plan)
        
        URLSession.shared.dataTask(with: request){data, response, error in
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else{
                complection(nil)
                print(error?.localizedDescription)
                return
            }
            let secret = try? JSONDecoder().decode(Payment.self,from: data)
            print("secret")
            complection(secret?.clientSecret)
            
        }.resume()
    }
    
    func pay(){
        guard let secret = PaymentConfig.shared.paymentIntentClientSecret else{
            return
        }
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: secret)
        paymentIntentParams.paymentMethodParams = paymentMethod
        paymentGateway.submitPayment(intent: paymentIntentParams){status,intnet,error in
            
            switch status{
            case .failed:
                print("Failed")
            case .canceled:
                print("Cancled")
            case.succeeded:
                print("yayy")

            case .none:
                print("S")
            }
        }
    }
}



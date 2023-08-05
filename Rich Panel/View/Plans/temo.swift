//
//  temo.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 05/08/23.
//

import SwiftUI
import StripePaymentSheet

struct CheckoutView: View {
  
    @ObservedObject var model = MyBackendModel()

    var plan: Plans
    
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
            VStack {
                if let paymentSheet = model.paymentSheet {
                    PaymentSheet.PaymentButton(
                        paymentSheet: paymentSheet,
                        onCompletion: model.onPaymentCompletion
                    ) {
                        Text("Buy")
                    }
                } else {
                    Text("Loading…")
                }
                if let result = model.paymentResult {
                    switch result {
                    case .completed:
                        Text("Payment complete")
                            
                            
                    case .failed(let error):
                        Text("Payment failed: \(error.localizedDescription)")
                    case .canceled:
                        Text("Payment canceled.")
                    }
                    
                }
                
            }.onAppear() {
                PaymentConfig.plan = plan
                model.preparePaymentSheet()
                model.updateSubscription()

                
            }
        }
        
        
    }
}

//
//  PaymentGatewayController.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 05/08/23.
//

import Foundation
import Stripe
import UIKit

class PaymentGatewayController: UIViewController{
    func submitPayment(intent: STPPaymentIntentParams,complection: @escaping
                       (STPPaymentHandlerActionStatus?,STPPaymentIntent?,NSError?) -> Void){
        let paymentHandler = STPPaymentHandler.shared()
        paymentHandler.confirmPayment(intent, with: self) { status, intent, error in
            complection(status,intent,error!)
        }
    }
}
extension PaymentGatewayController: STPAuthenticationContext{
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
    
    
}

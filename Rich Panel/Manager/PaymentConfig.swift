//
//  PaymentConfig.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 05/08/23.
//

import Foundation

class PaymentConfig{
    
    var paymentIntentClientSecret: String?
    static var shared: PaymentConfig = PaymentConfig ()
    static var plan: Plans =  Plans(devices: Devices(name: "Mobile"), plan: Plan(monthlyPrice: 100, videoQuality: "Good", resolution: "480p", devicesSuppoted: ["Phone","Table"]), duration: "Monthly")
    private init() { }
}

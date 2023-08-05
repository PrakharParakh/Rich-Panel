//
//  Rich_PanelApp.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 04/08/23.
//

import SwiftUI
import Firebase
import Stripe
@main
struct Rich_PanelApp: App {
    @AppStorage("signIn") var isSignIn: Bool = false

    init(){
        FirebaseApp.configure()
        StripeAPI.defaultPublishableKey = "pk_test_51NbN0USBw4MzCKwA3NQh1aTIu8tYhQMYvktSIaL9ps5JxffBS7KXZmISY3vWes94mzYeOtIX3hiYxm2hmww0qxAU00CSI6s0AX"
    }
    var body: some Scene {
        WindowGroup {
            if !isSignIn{
                LoginView()
            }
            else{
                ContentView()
                    .onOpenURL { incomingURL in
                        let stripeHandled = StripeAPI.handleURLCallback(with: incomingURL)
                        if (!stripeHandled) {
                            // This was not a Stripe url – handle the URL normally as you would
                            
                        }
                        
                    }
            }
        }
    }
}

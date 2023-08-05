//
//  Filler.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 05/08/23.
//

import SwiftUI

struct Filler: View {
    @StateObject var loginViewModel = LoginViewModel()
    var body: some View {
        VStack{
            if loginViewModel.alreadySubscribed{
                Text("Welcome")
            }
            else{
                PlansView()
            }
        }.onAppear{
            loginViewModel.checkSubscription()
        }
    }
}

struct Filler_Previews: PreviewProvider {
    static var previews: some View {
        Filler()
    }
}

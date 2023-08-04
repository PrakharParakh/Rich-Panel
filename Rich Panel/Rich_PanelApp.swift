//
//  Rich_PanelApp.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 04/08/23.
//

import SwiftUI
import Firebase

@main
struct Rich_PanelApp: App {
    @AppStorage("signIn") var isSignIn: Bool = false

    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if !isSignIn{
                LoginView()
            }
            else{
                ContentView()
            }
        }
    }
}

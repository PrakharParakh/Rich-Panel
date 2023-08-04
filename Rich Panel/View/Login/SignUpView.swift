//
//  SignUpView.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 04/08/23.
//

import SwiftUI

struct SignUpView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @AppStorage("signIn") var isSignIn: Bool = false
    @StateObject var signUpManager = SignUpManager()
    
    var body: some View {
        VStack{
            Text("Create Account")
                .font(.title2)
            
            VStack(alignment: .center){
                TextField("Name", text: $name)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black)
                            .frame(height: 40)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                
                TextField("Email", text: $email)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black)
                            .frame(height: 40)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black)
                            .frame(height: 40)
                    }
                    .padding(.leading)
                    .padding(.trailing)
            }
            
            Button{
                signUpManager.createUser(name: name,email: email, password: password)
            }label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                    }
            }
        }.onChange(of: signUpManager.success) { newValue in
            isSignIn = newValue
            print(isSignIn)
        }

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

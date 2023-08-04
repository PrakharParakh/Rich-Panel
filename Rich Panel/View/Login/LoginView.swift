//
//  LoginView.swift
//  Rich Panel
//
//  Created by Prakhar Parakh on 04/08/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @AppStorage("signIn") var isSignIn: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Login to your account")
                    .font(.title2)
                
                VStack(alignment: .center){
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
                    
                }label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue)
                        }
                }
                NavigationLink(destination: SignUpView()) {
                    Text("New? Sign Up")
                }
            }

        }
        
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

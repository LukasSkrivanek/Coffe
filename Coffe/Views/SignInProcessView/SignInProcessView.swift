//
//  SignInProccesView.swift
//  Coffe
//
//  Created by macbook on 10.03.2024.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct SignInProcessView: View {
    @State private(set) var viewModel:  AuthenticationViewModel
    @Binding var isSignedIn: Bool
    var body: some View {
        if isSignedIn {
            AccountView(isSignedIn: $isSignedIn)
        } else {
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task{
                    do{
                        try await viewModel.signInGoogle()
                    }catch{
                        print(error)
                    }
                }
            }
            .padding()
            
            
        }
       
        
    }
}

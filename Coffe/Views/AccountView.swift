//
//  AccountView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI
import GoogleSignInSwift


struct AccountView: View {
    @Environment(UserRepository.self) private var  userRepository
    @Environment(AccountViewModel.self) private var accountViewModel
    @Environment(AuthenticationViewModel.self) private var viewModel
    @Binding var isSignedIn: Bool
    @ViewBuilder
    private func logOutButton() -> some View {
        Button {
            userRepository.removeUser()
            accountViewModel.setup(user: nil)
            isSignedIn.toggle()
            print(isSignedIn)
        } label: {
            Text("Log Out")
        }

    }
    
    var body: some View {
        @Bindable var accountViewModel = accountViewModel
        NavigationStack{
            Form{
                Section("Personal info"){
                    TextField("First Name", text: $accountViewModel.name)
                    TextField("Adress", text: $accountViewModel.address)
                    TextField("Mobile", text: $accountViewModel.mobile)
                    
                }
               
                
                Section{
                    Button {
                        // save user details
                        userRepository.saveChanges(name: accountViewModel.name, address: accountViewModel.address, mobile: accountViewModel.mobile, email: accountViewModel.email)
                    } label: {
                        Text(userRepository.user != nil ? "Update" : "Create")
                    }
                }
                .disabled(accountViewModel.isInvalidForm())
                
                Section {
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
            .navigationTitle("🧷 My Account")
            .toolbar{
                ToolbarItem(placement: .primaryAction) {
                    if userRepository.user != nil {logOutButton()}
                }
            }
            .onAppear{
                accountViewModel.setup(user: userRepository.user)
            }
        }
    }
}

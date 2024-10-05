//
//  AppTabView.swift
//  CoffeTests
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct AppTabView: View {
    @Environment(UserRepository.self) private var  userRepository
    @Environment(AccountViewModel.self) private var accountViewModel
    @State var isSignedIn: Bool = true
    @State var authenticationViewModel = AuthenticationViewModel()
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            BasketView()
                .tabItem{
                    Image(systemName: "bag")
                    Text("Basket")
                }
            if isSignedIn {
                SignInProcessView(viewModel: authenticationViewModel, isSignedIn: $isSignedIn)
                    .tabItem{
                        Image(systemName: "person")
                        Text("Account")
                    }
            } else {
                AccountView(isSignedIn: $isSignedIn)
                    .tabItem{
                        Image(systemName: "person")
                        Text("Account")
                    }
            }
        }
        .onAppear {
            // Zjistíme, zda je uživatel přihlášen
            if  let user = userRepository.user  {
                accountViewModel.setup(user: user)
                print(user)
                isSignedIn = true // Pokud je uživatel nalezen, nastavíme isSignedIn na true
            } else {
                isSignedIn = false // Pokud uživatel není, nastavíme isSignedIn na false
            }
        }
    }
}

#Preview {
    AppTabView()
}

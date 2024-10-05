//
//  CoffeApp.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import SwiftUI
import FirebaseCore

@main
struct CoffeApp: App {
    init() {
        FirebaseApp.configure()
    }
    @State private var order = BasketViewModel()
    @State private var userRepository = UserRepository()
    @State private var homeViewModel = HomeViewModel()
    @State private var accountViewModel = AccountViewModel()
    @State private var  viewModel =   AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environment(order)
                .environment(userRepository)
                .environment(homeViewModel)
                .environment(accountViewModel)
                .environment(viewModel)
        }
    }
}

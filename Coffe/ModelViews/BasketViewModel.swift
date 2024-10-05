//
//  BasketViewModel.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import Foundation
import Firebase

@Observable
final class BasketViewModel{
    private let firebaseRepository = FirebaseRepository()
    private(set)var items: [Drink] = []
    var basketError: AppError?
    var showError = false
    
    func add(drink: Drink){
        items.append(drink)
        print("\(items.count)")
    }
    
    func deleteItems(at offsets: IndexSet){
        items.remove(atOffsets: offsets)
    }
    
    var totalprice: Double {
        items.reduce(0) {$0 + $1.price}
    }
    
    func createOrder(for user: UserModel?){
        guard  !items.isEmpty else {
            basketError = .emptyBasketError
            showError = true
            return
        }
        
        guard let user = user else {
            basketError = .noUserError
            showError = true
            print("User Error Model")
            return
        }

        guard Auth.auth().currentUser != nil else {
            basketError = .noUserError
            showError = true
            return
        }
        
        let order = Order(id: UUID().uuidString, customerName: user.name
                          , customerAdress: user.address, customerMobile: user.mobile, items: items, orderTotal: totalprice)
        
        firebaseRepository.placeOrder(order: order)
        items = []
        
    }
}

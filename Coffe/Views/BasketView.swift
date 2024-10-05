//
//  BasketView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct BasketView: View {
    @Environment(BasketViewModel.self) private var order
    @Environment(UserRepository.self) private var  userRepository
    @ViewBuilder
    private func placeOrderButton() -> some View{
        Button(action: {
            order.createOrder(for: userRepository.user)
        }, label: {
            Text("\(order.totalprice, format: .currency(code: "EUR")) - Place Order" )
        })
        .buttonStyle(.borderedProminent)
        .padding(.bottom, 30)
    }
    var body: some View {
        @Bindable var order = order
        NavigationStack{
            ZStack{
                VStack{
                    List{
                        ForEach(order.items){drink in
                            DrinkRow(drink: drink, didClickRow: {})
                        }
                        .onDelete(perform: order.deleteItems)
                    }
                    .listStyle(.grouped)
                    .safeAreaInset(edge: .bottom) {
                        placeOrderButton()
                    }
                }
                if order.items.isEmpty{
                    ContentUnavailableView {
                        Image(systemName: "list.bullet.clipboard")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.gray, .red, .green)
                            .font(.system(size: 120))
                    } description: {
                        Text("You have no items in your basket \n Please add some")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
            }
            .navigationTitle("🛒 Basket")
            .alert(isPresented: $order.showError) {
                Alert(title: Text("Error"), message: Text(order.basketError?.description ?? ""), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    BasketView()
}

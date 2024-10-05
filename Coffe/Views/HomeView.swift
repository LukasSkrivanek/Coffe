//
//  ContentView.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//

import SwiftUI

struct HomeView: View {
    @Environment(HomeViewModel.self) private var viewModel
    @State private var isShowingDetail = false
    var body: some View {
        @Bindable var viewModel = viewModel
        ZStack{
            NavigationStack{
                List(viewModel.filterCategories.keys.sorted(), id: \String.self){key in
                    Section {
                        if let drinks = viewModel.categories[key]{
                            ForEach(drinks){drink in
                                DrinkRow(drink: drink){
                                    viewModel.selectDrink(drink: drink)
                                    isShowingDetail = true
                                }
                            }
                        }
                    } header: {
                        Text(key)
                            .font(.subheadline)
                    }

                }
                .navigationTitle("☕️ Home")
                .searchable(text: $viewModel.searchText,placement: .automatic, prompt: Text("Search for your drink"))
                .onAppear{
                    Task {
                            await viewModel.fetchDrinks()
                        }
                }
                .blur(radius: isShowingDetail ? 20 : 0)
                .disabled(isShowingDetail)
                }
            if isShowingDetail {
                if let drink = viewModel.selectedDrink{
                    DrinkDetailView(drink: drink, isShowingDetail: $isShowingDetail)
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(HomeViewModel())
}

//
//  HomeViewModel.swift
//  Coffe
//
//  Created by macbook on 26.02.2024.
//
import Foundation

@Observable
final class HomeViewModel {
    private let firebaseRepository = FirebaseRepository()
    private(set) var drinks: [Drink] = []
    private(set) var selectedDrink: Drink?
    private(set)var filterCategories: [String : [Drink]] = [:]
    var searchText: String = "" {
        didSet{
            filterCategoriesFunc()
        }
    }
    var categories: [String: [Drink]]{
        .init(
            grouping: drinks) { $0.category.rawValue }
    }
   
    private func filterCategoriesFunc(){
            if searchText.isEmpty {
                filterCategories = categories
        } else {
            filterCategories = [:]
            
            // Iterate over each key-value pair in categories
            for (key, drinks) in categories {
                // Filter the drinks whose name contains the searchText
                let filteredDrinks = drinks.filter { $0.name.lowercased().contains(searchText.lowercased())}
                // If filteredDrinks is not empty, add it to the filterCategories dictionary
                if !filteredDrinks.isEmpty {
                    filterCategories[key] = filteredDrinks
                }
            }
        }
    }
    
    
     func fetchDrinks() async {
        do {
            drinks = try await firebaseRepository.fetchDrinks()
            filterCategoriesFunc()
        } catch  {
            print("Error fetching drinks", error.localizedDescription)
        }
    }
    /*
    func saveMenu(){
        firebaseRepository.saveDrinks()
    }
     */
    
    func selectDrink(drink: Drink){
        selectedDrink = drink
    }
    
}

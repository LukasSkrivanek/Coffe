//
//  FColletionReference.swift
//  Coffe
//
//  Created by macbook on 28.02.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

enum FCollectionReference: String {
    case Orders, Drinks
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    Firestore.firestore().collection(collectionReference.rawValue)
}
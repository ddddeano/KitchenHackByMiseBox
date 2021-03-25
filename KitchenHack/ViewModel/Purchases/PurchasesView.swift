//
//  PurchasesView.swift
//  KitchenHack
//
//  Created by Daniel Watson on 26/02/2021.
//

import SwiftUI

class PurchasesViewModel: ObservableObject {
    var dataModel = IngredientControlModel()
    @Published var purchases = [Purchase]()
    func Read() {
        purchases = dataModel.Read(.purchase) as! [Purchase]
    }
    init() { Read() }
}
struct PurchasesView: View {
    @StateObject var VM = PurchasesViewModel()
    var body: some View {
        List{
            ForEach(VM.purchases, id: \.objectID) { purchase in
                HStack{
                    Text(purchase.ingredient.name ?? "")
                    Text(purchase.supplier.name ?? "none")
                }
            }
        }
    }
}

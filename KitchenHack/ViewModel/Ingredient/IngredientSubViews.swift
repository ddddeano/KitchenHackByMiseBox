//
//  IngredientSubViews.swift
//  KitchenHack
//
//  Created by Daniel Watson on 17/03/2021.
//

import SwiftUI

struct IngredientsView: View {
    @StateObject var VM = IngredientsViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(VM.ingredients, id: \.objectID) { ingredient in
                    IngredientRow(VM: VM, ingredient: ingredient)
                }
                .onDelete(perform: VM.Delete)
            }
            .listStyle(InsetListStyle())
            .padding()
            .sheet(
                isPresented: $VM.showAddNewIngredientSheet,
                content: {
                    NewIngredientSheet(VM: VM)
                })
            .alert(
                isPresented: $VM.showNoCurrentSupplierAlert) {
                Alert(
                    title: Text(CT.noSuppliersAlert),
                    message: Text(CT.noSupplierAlertMessage),
                    dismissButton: .default(Text(CT.noSupplierOk))
                )}
            .navigationBarItems(
                leading: Text(CT.sectionTitle),
                trailing: Image(systemName: SS.AddNew)
                    .onTapGesture {
                        VM.GuardSheet()
                    })
        }
    }
    var SS = Style()
    var CT = Content()
}
struct NewIngredientSheet: View {
    @ObservedObject var VM: IngredientsViewModel
    var body : some View {
        List {
            TextField("Add New Ingredient", text: $VM.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Picker("pick supplier", selection: $VM.pickerIndex) {
                ForEach(0..<VM.suppliers.count) { supplier in
                    Text(self.VM.suppliers[supplier].wrappedName)
                }
            }
            Text(String(VM.suppliers[VM.pickerIndex].wrappedName))
            Image(systemName: "plus")
                .onTapGesture {
                    VM.Create()
                    self.pm.wrappedValue.dismiss()
            }
        }
    }
    @Environment(\.presentationMode) var pm
}
struct IngredientRow: View {
    @ObservedObject var VM: IngredientsViewModel
    var ingredient: Ingredient
    var body: some View {
        NavigationLink(destination: IngredientDetailView(VM: VM, ingredient: ingredient)) {
            HStack {
                Image("peach")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(ingredient.name ?? "")
                }
                Spacer()
                HStack {
                    Image(systemName: "pencil.circle.fill")
                    Image(systemName: "pencil.circle")
                }
            }
            .padding()
        }
    }
}
struct SupplierListView: View {
    var suppliers: [Supplier]
    var body: some View {
        List {
            ForEach(suppliers) { section in
                Text(section.wrappedName)
                ForEach(section.purchaseArray) { purchase in
                    Text("purchase")
                }
            }
        }
    }
}

struct PurchaseListView: View {
    var purchases: [Purchase]
    var body: some View {
        List {
            ForEach(purchases) { purchase in
                Text("PURCHASE")
            }
        }
    }
}
struct IngredientDetailView: View {
    @StateObject var VM: IngredientsViewModel
    var ingredient: Ingredient
    var body: some View {
        VStack {
            Text(VM.name)
            ToggleBar(listType: $VM.showList)
            switch VM.showList {
            case .list:
                PurchaseListView(purchases: ingredient.purchaseArray)
            case .supplier:
                SupplierListView(suppliers: ingredient.supplierArray)
            }
        }
    }
}










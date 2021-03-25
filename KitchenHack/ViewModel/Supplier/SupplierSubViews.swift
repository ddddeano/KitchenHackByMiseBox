//
//  SupplierSubViews.swift
//  KitchenHack
//
//  Created by Daniel Watson on 26/02/2021.
//

import SwiftUI

struct NewSupplierSheet: View {
    @ObservedObject var VM: SuppliersViewModel
    var body: some View {
        VStack {
            TextField("Supplier Name", text: $VM.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("email", text: $VM.email)
            Image(systemName: "plus")
                .onTapGesture {
                    VM.Create()
                    VM.Read()
                    self.pm.wrappedValue.dismiss()
                }
            }
        }
    @Environment(\.presentationMode) var pm
}
struct SuppliersView: View {
    @StateObject var VM = SuppliersViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(VM.suppliers, id: \.objectID) { supplier in
                    SupplierRow(VM: VM, supplier: supplier)
                }
                .onDelete(perform: VM.Delete)
            }
            .listStyle(InsetListStyle())
            .padding()
            .sheet(isPresented: $VM.showSheet, content: {
                NewSupplierSheet(VM: VM)
            })
            .navigationBarItems(
                leading: Text("Suppliers"),
                trailing: Image(systemName: "plus.circle")
                    .onTapGesture {
                        VM.showSheet = true
            })
        }
    }
}
struct SupplierRow: View {
    @ObservedObject var VM: SuppliersViewModel
    var supplier: Supplier
    var body: some View {
        NavigationLink(destination: SupplierDetailView(VM: VM, supplier: supplier)) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
                VStack {
                    Text(supplier.wrappedName)
                    Text(supplier.wrappedEmail)
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
struct SupplierDetailView: View {
    @ObservedObject var VM: SuppliersViewModel
    var supplier: Supplier

    var body: some View {
        TextField("\(supplier.wrappedName)", text: $VM.name)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        TextField("\(supplier.wrappedEmail)", text: $VM.email)
        Image(systemName: "pencil")
            .onTapGesture {
                VM.Update(supplier)
                self.pm.wrappedValue.dismiss()
            }
        }
    @Environment(\.presentationMode) var pm
}




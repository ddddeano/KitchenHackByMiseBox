//
//  SupplierView.swift
//  KitchenHack
//
//  Created by Daniel Watson on 26/02/2021.
//

import SwiftUI

class SuppliersViewModel: ObservableObject {
    var dataModel = IngredientControlModel()
    @Published var suppliers = [Supplier]()
    @Published var showSheet = false
    @Published var existsAlert = false
    @Published var name = ""
    @Published var email = ""
    
    func Create(){
        let supplier = Supplier(context: dataModel.moc)
        supplier.name = name
        supplier.email = email
        dataModel.CreateSupplier(supplier)
        Reset()
    }
    func Read() {
        suppliers = dataModel.Read(.supplier) as! [Supplier]
    }
    func Update(_ supplier: Supplier) {
        let fields = ["name" : name, "email" : email]
        for (key, value) in fields {
            dataModel.UpdateSupplier(supplier, key: key, value: value)
        }
        Reset()
        Read()
    }
    func Delete(indexSet: IndexSet) {
        for index in indexSet {
            let obj = suppliers[index]
            dataModel.Delete(obj)
            
            let index = suppliers.firstIndex(of: obj)
            suppliers.remove(at: index!)
        }
    }
    func Reset() {
        name = ""
        email = ""
    }
    init() { Read() }
}

//
//  ToggleBar.swift
//  KitchenHack
//
//  Created by Daniel Watson on 19/03/2021.
//

import SwiftUI

struct ToggleBar: View {
    
    @Binding var listType: IngredientsViewModel.ListType
    
    var body: some View {
        HStack {
            Button(action: {
                listType = .supplier
            }) {
                Image(systemName: "person.3")
            }.buttonStyle(CustomButtonStyle(isOn: listType == .supplier))
            
            Button(action: {
                listType = .list
            }) {
                Image(systemName: "list.dash")
            }.buttonStyle(CustomButtonStyle(isOn: listType == .list))
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    var isOn: Bool
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 60, height: 30)
            configuration.label
                .foregroundColor(isOn ? .green : .red)
        }
    }
}

struct ToggleBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ToggleBar(listType: .constant(.supplier))
        }
    }
}

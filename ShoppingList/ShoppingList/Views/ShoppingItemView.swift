//
//  ShoppingItemView.swift
//  ShoppingList
//
//  Created by Paolo on 09/01/21.
//

import SwiftUI

struct ShoppingItemView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var itemName: String = "";
    @State var itemPriceUnit: String = "0";
    @State var itemPriceCents: String = "0";
    @State var itemQuantity: String = "0";
    @State var itemBrand: String = "";
    
    var body: some View {
        VStack {
            Image(systemName: "bag")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .font(.system(size: 60))
                .padding()
            HStack {
                Text("Name")
                    .foregroundColor(Color.blue)
                    .frame(width: 150)
                TextField("name", text: $itemName)
                    .frame(width: 150)
            }
            HStack {
                Text("Name")
                    .frame(width: 150)
                    .foregroundColor(Color.blue)
                TextField("name", text: $itemName)
                    .frame(width: 150)
            }
            HStack {
                Text("Quantity")
                    .frame(width: 150)
                    .foregroundColor(Color.blue)
                TextField("quantity", text: $itemQuantity)
                    .frame(width: 150)
            }
            HStack {
                Text("Brand")
                    .frame(width: 150)
                    .foregroundColor(Color.blue)

                TextField("brand", text: $itemName)
                    .frame(width: 150)

            }
            .padding()
            Button(action: saveNewItem) {
                Text("Save")
                    .frame(width: 300, height: 50)
                    .border(Color.blue, width: 1)
            }
        }
        .padding()
        .navigationTitle("Add Item")

    }
    private func saveNewItem() {
        print("Save item!")
        self.presentationMode.wrappedValue.dismiss()
        print("Dismissed")
    }
}

struct ShoppingItemView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulShoppingItemView()
    }
}

struct StatefulShoppingItemView: View {
    var body: some View {
        ShoppingItemView()
    }
}

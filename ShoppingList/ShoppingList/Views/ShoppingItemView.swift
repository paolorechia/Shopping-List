//
//  ShoppingItemView.swift
//  ShoppingList
//
//  Created by Paolo on 09/01/21.
//

import SwiftUI

struct ShoppingItemView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @Environment(\.presentationMode) var presentationMode

    @Binding var itemName: String;
    @Binding var itemPriceUnit: String;
    @Binding var itemPriceCents: String;
    @Binding var itemQuantity: String;
    @Binding var itemBrand: String;
    
    @State var priceString: String = "0,00"
    
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
                Text("Price")
                    .frame(width: 150)
                    .foregroundColor(Color.blue)
                TextField("name", text: $priceString)
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

                TextField("brand", text: $itemBrand)
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
        print("Saving item!")
        addItemToPersistence()
        print("Saved item!")
        self.presentationMode.wrappedValue.dismiss()
        print("Dismissed")
    }

    private func addItemToPersistence() {
        withAnimation {
            let newItem = ShoppingItem(context: viewContext)
            newItem.name = "New"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ShoppingItemView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulShoppingItemView()
    }
}

struct StatefulShoppingItemView: View {
    
    @State var itemName: String = "";
    @State var itemPriceUnit: String = "0";
    @State var itemPriceCents: String = "0";
    @State var itemQuantity: String = "0";
    @State var itemBrand: String = "";
    
    var body: some View {
        ShoppingItemView(
            itemName: $itemName,
            itemPriceUnit: $itemPriceUnit,
            itemPriceCents:$itemPriceCents,
            itemQuantity: $itemQuantity,
            itemBrand: $itemBrand
        ).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

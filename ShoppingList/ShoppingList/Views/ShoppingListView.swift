//
//  ShoppingListView.swift
//  ShoppingList
//
//  Created by Paolo on 09/01/21.
//

import SwiftUI

struct ShoppingListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State var itemName: String = "";
    @State var itemPriceUnit: String = "";
    @State var itemPriceCents: String = "";
    @State var itemQuantity: String = "";
    @State var itemBrand: String = "";
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ShoppingItem.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ShoppingItem>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { (item: ShoppingItem) in
                        VStack {
                            NavigationLink(
                                destination: ShoppingItemView(
                                    itemId: item.id,
                                    itemName: item.name,
                                    itemPriceUnit: String(item.priceUnit) ,
                                    itemPriceCents: String(item.priceCents) ,
                                    itemQuantity: String(item.quantity) ,
                                    itemBrand: item.brand ?? ""
                               )
                            ) {
                                Text("\(item.name)")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                HStack {
                    Button(action: finishShopping) {
                        Text("Finish")
                    }
                    .frame(width: 2000, height: 60)
                    .font(.title2)
                    .border(Color.blue, width: 1)
                }
            }
            .toolbar(content: {
                HStack {
                    EditButton()
                        .padding()
                    NavigationLink(destination: ShoppingItemView(
                        itemId: nil,
                        itemName: "",
                        itemPriceUnit: "",
                        itemPriceCents: "",
                        itemQuantity: "",
                        itemBrand: ""
                    )) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            })
        }.navigationBarHidden(true)

    }
    
    private func finishShopping() {
        self.presentationMode.wrappedValue.dismiss()
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

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

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListPreviewWrapper()
    }
}

struct ShoppingListPreviewWrapper: View {
    var body: some View {
        ShoppingListView().previewDevice("iPhone 11").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

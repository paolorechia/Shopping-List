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

    @ObservedObject var totalObject = ComputeTotal()
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
                                    itemBrand: item.brand ?? "",
                                    totalObject: totalObject
                               )
                            ) {
                                HStack {
                                    Text("\(item.name)")
                                    Text("R$\(item.priceUnit),\(item.priceCents)")
                                    Text("\(item.brand ?? "")")
                                    Text("\(item.quantity)")
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                VStack {
                    HStack {
                        Text("Total: \(totalObject.totalItemPrice)")
                    }
                    .padding()
                    HStack {
                        Button(action: finishShopping) {
                            Text("Finish")
                        }
                        .frame(width: 2000, height: 60)
                        .font(.title2)
                        .border(Color.blue, width: 1)
                    }
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
                        itemBrand: "",
                        totalObject: totalObject
                    )) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            })
        }.navigationBarHidden(true)
        .onAppear(perform: onAppearHandler)
            

    }
    
    private func onAppearHandler() {
        updateItemsTotals()
    }
    
    private func updateItemsTotals() {
        var shoppingItems: [ShoppingItem] = []
        for item in items {
            shoppingItems.append(item)
        }
        totalObject.update_totals(items: shoppingItems)
    }
    
    private func finishShopping() {
        self.presentationMode.wrappedValue.dismiss()
    }

    private func deleteItems(offsets: IndexSet) {
        var totalUnitsSubtracted: Int32 = 0
        var totalCentsSubtracted: Int32 = 0
        withAnimation {
            offsets.forEach {
                print("Iterating...")
                let item = items[$0]
                totalUnitsSubtracted += item.priceUnit
                totalCentsSubtracted += item.priceCents
                viewContext.delete(item)
            }
            do {
                print("Saving...")
                try viewContext.save()
                print("Subtracting...")
                DispatchQueue.main.async {
                    updateItemsTotals()
                }

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

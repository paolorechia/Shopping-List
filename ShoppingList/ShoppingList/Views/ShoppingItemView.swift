//
//  ShoppingItemView.swift
//  ShoppingList
//
//  Created by Paolo on 09/01/21.
//

import SwiftUI
import CoreData


struct ShoppingItemView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @Environment(\.presentationMode) var presentationMode

    var itemId: Optional<UUID>;
    @State var itemName: String;
    @State var itemPriceUnit: String;
    @State var itemPriceCents: String;
    @State var itemQuantity: String;
    @State var itemBrand: String;
    @Binding var itemTotalPrice: String;
    
    let currency = "R$"
    
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
                    .frame(width: 225)
                    .keyboardType(.numberPad)
            }
            .padding()
            HStack(alignment: .center) {
                Text("Price")
                    .frame(width: 150)
                    .foregroundColor(Color.blue)
                HStack {
                    Text(currency)
                        .foregroundColor(Color.blue)
                    TextField("units", text: $itemPriceUnit)
                        .frame(width: 70)
                        .keyboardType(.numberPad)
                    Text(",")
                        .font(.title)
                        .foregroundColor(Color.blue)
                    TextField("cents", text: $itemPriceCents)
                        .keyboardType(.numberPad)
                }
            }
            .padding()
            HStack {
                Text("Quantity")
                    .frame(width: 150)
                    .foregroundColor(Color.blue)
                TextField("quantity", text: $itemQuantity)
                    .frame(width: 180)
            }
            HStack {
                Text("Type")
                    .frame(width: 150)
                    .foregroundColor(Color.blue)
                Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Type")) {
                    Text("Units").tag(1)
                    Text("Kg").tag(2)
                    Text("g").tag(2)
                    Text("L").tag(2)
                    Text("ml").tag(2)
                }
                .frame(width: 220, height: 150)
            }
            .padding()
            HStack {
                Text("Brand")
                    .frame(width: 150)
                    .foregroundColor(Color.blue)
                TextField("brand", text: $itemBrand)
                    .frame(width: 225)

            }
            .padding()
            Button(action: saveNewItem) {
                Text("Save")
                    .frame(width: 300, height: 50)
                    .border(Color.blue, width: 1)
            }
            .padding()

        }
        .font(.title)
        .padding()
        .navigationTitle(itemId != nil ? "Edit Item" : "New Item")
    }

    private func saveNewItem() {
        print("Saving item!")
        let itemPriceUnitInt: Int = Int($itemPriceUnit.wrappedValue) ?? 0
        let itemPriceCentsInt: Int = Int($itemPriceCents.wrappedValue) ?? 0
        let itemQuantityInt: Int = Int($itemQuantity.wrappedValue) ?? 0
        
        if itemId == nil {
            addItemToPersistence(
                name: $itemName.wrappedValue,
                priceUnit: itemPriceUnitInt,
                priceCents: itemPriceCentsInt,
                quantity: itemQuantityInt,
                brand: $itemBrand.wrappedValue
            )
            print("Saved Item!")
        } else {
            // TODO
            print("Editing Item!")
            print("Defining request/predicate")
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingItem")
            let predicate = NSPredicate(format: "id = %@", argumentArray: [itemId!])
            fetchRequest.predicate = predicate

            do {
                print("Fetching")
                let fetchedEntities = try viewContext.fetch(fetchRequest) as! [ShoppingItem]
                print("Got it, unpacking first")
                fetchedEntities.first?.name = $itemName.wrappedValue
                fetchedEntities.first?.priceUnit = Int32(itemPriceUnitInt)
                fetchedEntities.first?.priceCents = Int32(itemPriceCentsInt)
                fetchedEntities.first?.quantity = Int32(itemQuantityInt)
                fetchedEntities.first?.brand = $itemBrand.wrappedValue


                print("Updated!!")
                // ... Update additional properties with new values
            } catch {
                // Do something in response to error condition
            }

        }

        // Reset View State
        itemName = ""
        itemPriceUnit = ""
        itemPriceCents = ""
        itemQuantity = ""
        itemBrand = ""

        // Update Total Value
        
        
        self.presentationMode.wrappedValue.dismiss()
    }

    private func addItemToPersistence(
        name: String,
        priceUnit: Int,
        priceCents: Int,
        quantity: Int,
        brand: String
    ) {
        withAnimation {
            let newItem = ShoppingItem(context: viewContext)
            newItem.id = UUID.init()
            newItem.name = name
            newItem.priceUnit = Int32(priceUnit)
            newItem.priceCents = Int32(priceCents)
            newItem.quantity = Int32(quantity)
            newItem.brand = brand
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
    
    var itemName: String = "";
    var itemPriceUnit: String = "";
    var itemPriceCents: String = "";
    var itemQuantity: String = "";
    var itemBrand: String = "";
    @State var itemTotal: String = "0";
    
    var body: some View {
        ShoppingItemView(
            itemId: nil,
            itemName: itemName,
            itemPriceUnit: itemPriceUnit,
            itemPriceCents: itemPriceCents,
            itemQuantity: itemQuantity,
            itemBrand: itemBrand,
            itemTotalPrice: $itemTotal
        )
        .environment(
            \.managedObjectContext,
            PersistenceController.preview.container.viewContext)
    }
}

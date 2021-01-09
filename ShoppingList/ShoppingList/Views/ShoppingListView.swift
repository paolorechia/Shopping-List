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

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ShoppingItem.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ShoppingItem>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
                        Text("\(item.name!)")
                    }
                    .onDelete(perform: deleteItems)
                }
                HStack {
                    Button(action: finishShopping) {
                        Text("Finish")
                    }

                }
            }
            .toolbar(content: {
                HStack {
                    EditButton()
                        .padding()
                    NavigationLink(destination: ShoppingItemView()) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            })
        }.navigationBarHidden(true)
    }
    
    private func finishShopping() {
        self.presentationMode.wrappedValue.dismiss()
    }

    private func addItem() {
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

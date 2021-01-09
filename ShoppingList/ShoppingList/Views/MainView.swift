//
//  MainView.swift
//  ShoppingList
//
//  Created by Paolo on 09/01/21.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            VStack() {
                Image(systemName: "cart")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 120))
                NavigationLink(destination: ShoppingListView().environment(\.managedObjectContext, viewContext)) {
                    Text("New Shopping")
                    .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .border(Color.blue, width: 1)
                    .padding()
                }
                NavigationLink(destination: HistoryListView().environment(\.managedObjectContext, viewContext)) {
                    Text("History")
                    .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .border(Color.blue, width: 1)
                }
            }
        }
    }
    
    func startShopping() {
        print("Start Shopping!")
    }
    
    func viewHistory() {
        print("View History")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().previewDevice("iPhone 11").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

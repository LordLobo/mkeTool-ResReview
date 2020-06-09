//
//  ContentView.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/4/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var editMode: EditMode = .inactive
    @State private var showAddSheet = false
    
    @ObservedObject private var dataSource = CoreDataSource<Resturant>()
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    List {
                        ForEach(self.dataSource.fetchedObjects, id:\.self) { resturant in
                            NavigationLink(destination: ResturantDetailView(resturant)) {
                                ResturantRow(resturant)
                            }
                        }
                        .onDelete(perform: self.dataSource.delete)
                    }
                    
                }
                .onAppear{ self.dataSource.loadDataSource() }
                .navigationBarTitle(Text("Resturants"), displayMode: .large)
                .navigationBarItems(trailing:
                    HStack {
                        Button(action: {
                            self.showAddSheet.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                    } )
                .environment(\.editMode, self.$editMode)
            }
            .padding(5)
            .frame(width: geo.size.width * 0.95)
            .background(Color("RtBg"))
            .cornerRadius(6)
            .sheet(isPresented: self.$showAddSheet) {
                AddResturantView()
            }
            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

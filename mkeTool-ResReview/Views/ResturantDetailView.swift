//
//  ResturantDetailView.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/9/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import SwiftUI

struct ResturantDetailView: View {
    var resturant: Resturant
    
    @ObservedObject private var dataSource = CoreDataSource<Review>(predicateKey: "resturant")
    
    @State private var showAddSheet = false
    
    init(_ resturant: Resturant) {
        self.resturant = resturant
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("ave")
                    
                    Spacer()
                    
                    VStack {
                        Text("\(self.resturant.name!)")
                        
                        Text("\(self.resturant.type!.resturantType!)")
                    }
                    
                    Spacer()
                }
                
                List {
                    ForEach(dataSource.loadDataSource(relatedTo: resturant), id:\.self){ review in
                        ReviewRow(review)
                    }
                }
                
            }
            .onAppear{ self.dataSource.loadDataSource() }
            .navigationBarTitle(Text("\(self.resturant.name!)"), displayMode: .large)
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        self.showAddSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                })
        }
        .sheet(isPresented: self.$showAddSheet) {
            AddReviewView(self.resturant)
        }
    }
}

struct ResturantDetailView_Previews: PreviewProvider {
    static var previews: some View {
         let context = CoreData.stack.context
               let resturant = Resturant.createResturant(name: "Test Resturant", type: ResturantType.createResturantType(resturantType: "TestCuisine"))
               
               return ResturantDetailView(resturant)
                        .environment(\.managedObjectContext, context)
    }
}

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
    
    @State private var showAddReview = false
    @State private var showEditResturant = false
    @State private var showActionSheet = false
    
    
    init(_ resturant: Resturant) {
        self.resturant = resturant
    }
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    HStack {
                        HStack {
                            AvgStar(self.resturant.avgReview())
                            Text("avg").padding(.leading, -10)
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        VStack {
                            Text("\(self.resturant.type!.resturantType!)")
                        }
                        
                        Spacer()
                    }
                    
                    List {
                        ForEach(self.dataSource.loadDataSource(relatedTo: self.resturant), id:\.self){ review in
                            ReviewRow(review)
                        }
                    }
                    
                }
                .onAppear{ self.dataSource.loadDataSource() }
                .navigationBarTitle(Text("\(self.resturant.name!) (\(self.resturant.reviews!.count.description))"), displayMode: .large)
                .navigationBarItems(trailing:
                    
                    HStack {
                        Button(action: {
                            self.showEditResturant = true
                            self.showAddReview = false
                            self.showActionSheet.toggle()
                        }) {
                            Text("Edit")
                        }
                        .padding(.trailing, 30)
                        
                        Button(action: {
                            self.showEditResturant = false
                            self.showAddReview = true
                            self.showActionSheet.toggle()
                        }) {
                            Text("Add Review")
                        }
                    })
            }
            .padding(5)
            .frame(width: geo.size.width * 0.95)
            .background(Color("RtBg"))
            .cornerRadius(6)
            .sheet(isPresented: self.$showActionSheet) {
                if (self.showAddReview) {
                    AddReviewView(self.resturant)
                }
                
                if (self.showEditResturant) {
                    EditResturantView(self.resturant)
                }
            }
            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
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

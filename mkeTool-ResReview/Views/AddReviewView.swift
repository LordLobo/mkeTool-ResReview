//
//  AddReviewView.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/9/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import SwiftUI

struct AddReviewView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var resturant: Resturant
    
    @State private var reviewText = ""
    @State private var reviewDate = Date.init()
    @State private var score = 0
    
    init(_ resturant: Resturant) {
        self.resturant = resturant
    }
    
    
    var body: some View {
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
            
            DatePicker(selection: self.$reviewDate, displayedComponents: .date) {
                Text("Date")
            }
            
            HStack {
                Image(systemName: self.score > 0 ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 10)
                    .onTapGesture { self.score = self.score == 1 ? 0 : 1 }
                
                Image(systemName: self.score > 1 ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 10)
                    .onTapGesture { self.score = self.score == 2 ? 1 : 2 }
                
                Image(systemName: self.score > 2 ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 10)
                    .onTapGesture { self.score = self.score == 3 ? 2 : 3 }
                
                Image(systemName: self.score > 3 ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 10)
                    .onTapGesture { self.score = self.score == 4 ? 3 : 4 }
                
                Image(systemName: self.score > 4 ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .onTapGesture { self.score = self.score == 5 ? 4 : 5 }
            }
                        
            Spacer()
            
            TextField("Review", text: self.$reviewText)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.saveReview()
                }) {
                    Text("Cancel")
                }
                    
                Spacer()
                    
                Button(action: {
                    self.saveReview()
                }) {
                    Text("Save")
                }
                .disabled(!self.dirty())
                
                Spacer()
            }
        }
    }
    
    func saveReview() {
        _ = Review.createReviewFor(resturant, text: self.reviewText, rating: self.score, date: self.reviewDate)
        self.cancelAction()
    }
    
    func cancelAction() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func dirty() -> Bool {
        return !self.reviewText.isEmpty
    }
}

struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        let context = CoreData.stack.context
        let resturant = Resturant.createResturant(name: "Test Resturant", type: ResturantType.createResturantType(resturantType: "TestCuisine"))
        
        return AddReviewView(resturant)
                 .environment(\.managedObjectContext, context)
    }
}

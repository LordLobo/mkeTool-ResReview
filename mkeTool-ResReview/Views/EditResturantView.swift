//
//  EditResturantView.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/9/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import SwiftUI

struct EditResturantView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State private var name: String = ""
    @State private var type: String = ""
    
    private var resturant: Resturant
    
    init(_ editRes: Resturant) {
        self.resturant = editRes
    }
    
    let types = ResturantType.allResturantTypes()
            
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Edit \(self.name)")
                
                HorizontalLine(color: Color.gray, height: 4)
                
                TextField("Resturant Name", text: self.$name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Picker("Cuisine", selection: self.$type) {
                    ForEach(self.types, id: \.resturantType) { pickType in
                        Text("\(pickType.resturantType!)").tag(pickType.resturantType!)
                    }
                }
                
                HorizontalLine(color: Color.gray, height: 4)
                
                HStack {
                    Spacer()
                    
                    Button(action:{ self.cancelAction() }) { Text("Cancel") }
                    
                    Spacer()
                    
                    Button(action:{ self.saveAction() }) { Text("Save") }
                        .disabled(!self.dirty())
                    
                    Spacer()
                }
            }
            .padding(5)
            .frame(width: geo.size.width * 0.97)
            .background(Color("RtBg"))
            .cornerRadius(6)
            .onAppear {
                self.name = self.resturant.name!
                self.type = self.resturant.type!.resturantType!
            }
        }
    }
    
    func cancelAction() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        let pickedType = types.first { (x) -> Bool in
            return x.resturantType == self.type
        }
        
        self.resturant.name = self.name
        self.resturant.type = pickedType!
        
        CoreData.stack.save()
        
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        return !self.name.isEmpty
    }
}

struct EditResturantView_Previews: PreviewProvider {
    static var previews: some View {
        let context = CoreData.stack.context
        let resturant = Resturant.createResturant(name: "Test Resturant", type: ResturantType.createResturantType(resturantType: "TestCuisine"))

        return EditResturantView(resturant)
                    .environment(\.managedObjectContext, context)
    }
}

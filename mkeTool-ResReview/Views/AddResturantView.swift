//
//  AddResturantView.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/8/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import SwiftUI

struct AddResturantView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State private var name: String = ""
    @State private var type: String = "Mexican"
    
    let types = ResturantType.allResturantTypes()
    		
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Add Resturaunt")
                
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
        }
    }
    
    func cancelAction() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        let pickedType = types.first { (x) -> Bool in
            return x.resturantType == self.type
        }
        _ = Resturant.createResturant(name: self.name, type: pickedType!)
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        return !self.name.isEmpty
    }
}

struct AddResturantView_Previews: PreviewProvider {
    static var previews: some View {
        AddResturantView()
    }
}

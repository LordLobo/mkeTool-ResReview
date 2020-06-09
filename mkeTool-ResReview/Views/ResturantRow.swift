//
//  ResturantRow.swift
//  mkeTool-ResReview
//
//  Created by Dan Giralte on 6/8/20.
//  Copyright © 2020 Dan Giralte. All rights reserved.
//

import SwiftUI

struct ResturantRow: View {
    var resturant: Resturant
    
    init(_ resturant: Resturant) {
        self.resturant = resturant
    }
    
    var body: some View {
        HStack {
            Text("ave")
            
            Spacer()
            
            VStack {
                Text("\(self.resturant.name!)")
                
                Text("\(self.resturant.type!.resturantType!)")
            }
            
            Spacer()
            
            Text("\(self.resturant.reviews!.count)")
        }
    }
}

struct ResturantRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = CoreData.stack.context
        let resturant = Resturant.createResturant(name: "Test Resturant", type: ResturantType.createResturantType(resturantType: "TestCuisine"))
        
        return ResturantRow(resturant)
                .environment(\.managedObjectContext, context)
                .previewLayout(.sizeThatFits)
                .padding(10)
    }
}

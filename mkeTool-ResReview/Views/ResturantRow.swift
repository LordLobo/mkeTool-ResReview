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
            AvgStar(self.resturant.avgReview())            
            
            VStack(alignment: .leading) {
                Text("\(self.resturant.name ?? "")")
                    .font(Font.system(size: 21.0, weight: .bold))
                
                Text("\(self.resturant.type!.resturantType ?? "")")
                    .font(Font.system(size: 14))
            }
            
            Spacer()
            
            Text("\(self.resturant.reviews!.count)")
                .padding(.trailing)
        }
        .padding(5)
        .background(Color("RtBg"))
        .cornerRadius(6)
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

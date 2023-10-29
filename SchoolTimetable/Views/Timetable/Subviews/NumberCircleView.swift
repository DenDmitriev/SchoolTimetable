//
//  NumberCircleView.swift
//  Calendar
//
//  Created by Denis Dmitriev on 27.10.2023.
//

import SwiftUI

struct NumberCircleView: View {
    
    let number: Int
    let color: Color
    
    var body: some View {
        Text((number + 1).formatted(.number))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.footnote)
            .fontWeight(.heavy)
            .background(
                Circle()
                    .fill(color)
                    .frame(maxWidth: 30)
            )
    }
}

struct NumberCircleView_Previews: PreviewProvider {
    static var previews: some View {
        NumberCircleView(number: 5, color: .blue)
    }
}

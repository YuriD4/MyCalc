//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI

public struct TabItem: View {
    let imageName: String
    let title: String

    public init(imageName: String, title: String) {
        self.imageName = imageName
        self.title = title
    }
    
    public var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
            Text(title)
        }
        .padding()
    }
}

struct TabItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            TabItem(imageName: "gear", title: "Settings")
            TabItem(imageName: "gamecontroller", title: "Calculator")
        }
    }
}

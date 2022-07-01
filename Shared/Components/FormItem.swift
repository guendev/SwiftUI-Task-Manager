//
//  FormItem.swift
//  Task Manager
//
//  Created by Yuan on 02/07/2022.
//

import SwiftUI

struct FormItem<Content: View>: View {
    
    let content: Content
    let title: String
        
    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            content
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct FormItem_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
    }
}

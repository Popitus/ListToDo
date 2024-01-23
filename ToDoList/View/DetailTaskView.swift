//
//  DetailTaskView.swift
//  ToDoList
//
//  Created by Oliver Ramírez Cáceres on 23/1/24.
//

import SwiftUI

struct DetailTaskView: View {
    @State var tag = String()
    var body: some View {
        Text("\(tag)")
    }
}

#Preview {
    DetailTaskView(tag: "Prueba")
}

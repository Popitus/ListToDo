//
//  AddTaskView.swift
//  ToDoList
//
//  Created by Oliver Ramírez Cáceres on 15/1/24.
//

import SwiftUI

struct AddTaskView: View {
    
    @Binding var newTaskTitle: String
    var addAdction: () -> Void
    
    var body: some View {
        HStack {
            TextField("Nueva Tarea", text: $newTaskTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                addAdction()
                newTaskTitle = ""
            }, label: {
                Text("Agregar")
            })
        }
    }
}

#Preview {
    @State var newTaskTitle: String = ""
    return AddTaskView(newTaskTitle: $newTaskTitle, addAdction: {})
}

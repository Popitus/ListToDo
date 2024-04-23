//
//  AlertPopUp.swift
//  ToDoList
//
//  Created by Adrian Iraizos Mendoza on 23/4/24.
//

import SwiftUI

struct AlertPopUp: View {
    var title: String
    var message: String
    var hintText: String
    var primaryTitle: String
    var secondaryTitle: String
    var primaryAction: (String) -> Void
    var secondaryAction: () -> Void
    @State private var categoryName: String = ""
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
                .bold()
            Text(message)
                .font(.subheadline)
            TextField(hintText, text: $categoryName)
                .textFieldStyle(.roundedBorder)
                .padding()
            HStack(spacing:30) {
                Button {
                    secondaryAction()
                } label: {
                    Text(secondaryTitle)
                }
                .foregroundStyle(Color.red)
                Button {
                    primaryAction(categoryName)
                } label: {
                    Text(primaryTitle)
                }
            }
            .bold()
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(.ultraThinMaterial).padding(-20))
    }
}

#Preview {
    AlertPopUp(title: "Create category", message: "Create a new category for your tasks", hintText: "Category name", primaryTitle: "Add", secondaryTitle: "Discard") { text in
        
    } secondaryAction: {
        
    }
    .padding(40)
}

/*
 alertTextField(
 title: String(localized: "alert_title_category"),
 message: String(localized: "alert_message_category"),
 hintText: String(localized: "alert_title_category_placeholder"),
 primaryTitle: String(localized: "button_add"),
 secondaryTitle: String(localized: "button_discard"),
 primaryAction: { text in
 if !text.isEmpty {
 taskViewModel.addTaskPage(title: text)
 self.titleSelected = self.titleSelected.isEmpty ? String(localized: "title_select_category") : self.titleSelected
 }
 },
 secondaryAction: {}
 )
 }
 */

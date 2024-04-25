//
//  StickerSelectionView.swift
//  ToDoList
//
//  Created by Adrian Iraizos Mendoza on 25/4/24.
//

import SwiftUI

struct StickerSelectionView: View {
    var columns = [GridItem(),GridItem()]
    var action: () -> ()
    var body: some View {
        VStack {
            Text(String(localized:"select_sticker"))
                .font(.headline)
            LazyVGrid(columns: columns,spacing: 10) {
                ForEach(Sticker.allCases, id:\.self) { sticker in
                    Button {
                        action()
                    } label: {
                        sticker.image
                            .font(.largeTitle)
                    }
                    .tint(.black)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .padding(.vertical,-20)
        )
    }
}

#Preview {
    StickerSelectionView()  {}
        .padding()
}

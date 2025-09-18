//
//  IconPickerView.swift

import SwiftUI

struct IconPickerView: View {
    @Binding var selectedIcon: String // The icon name will be stored here
    @Environment(\.dismiss) var dismiss
    
    // A list of some common SF Symbols to choose from
    let icons = ["figure.walk", "book.fill", "leaf.fill", "drop.fill", "swift", "sun.max.fill", "moon.fill", "pencil", "camera.fill", "star.fill"]
    
    let columns = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(icons, id: \.self) { iconName in
                        Button(action: {
                            self.selectedIcon = iconName
                            dismiss()
                        }) {
                            Image(systemName: iconName)
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .background(selectedIcon == iconName ? Color.accentColor.opacity(0.3) : Color(.systemGray5))
                                .foregroundColor(selectedIcon == iconName ? .accentColor : .primary)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Seleccionar Ícono")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

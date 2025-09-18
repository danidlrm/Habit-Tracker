//
//  IconPickerView.swift

import SwiftUI

struct IconPickerView: View {
    @Binding var selectedIcon: String // enlace a EditView
    @Environment(\.dismiss) var dismiss
    
    // lista de SF Symbols
    let icons = ["figure.walk", "book.fill", "leaf.fill", "drop.fill", "swift", "sun.max.fill", "moon.fill", "pencil", "camera.fill", "star.fill"]
    
    let columns = [ //diseño de la cuadrícula
        GridItem(.adaptive(minimum: 60)) //grid con ancho min 60
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView { //desplazable si la pantalla se hace más grande
                LazyVGrid(columns: columns, spacing: 20) { //cuadricula vertical
                    ForEach(icons, id: \.self) { iconName in //crea un boton por cada icon enn el array
                        Button(action: {
                            self.selectedIcon = iconName
                            dismiss()
                        }) {
                            Image(systemName: iconName)
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .background(selectedIcon == iconName ? Color.accentColor.opacity(0.3) : Color(.systemGray5)) //? comprueba si esta seleccionado para el color
                                .foregroundColor(selectedIcon == iconName ? .accentColor : .primary)
                                .clipShape(RoundedRectangle(cornerRadius: 10)) //boton rectnagular
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Seleccionar Ícono")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { //boton dismiss
                    Button("Cancelar") {
                        dismiss() //cierra la hoja sin guardad cambios
                    }
                }
            }
        }
    }
}

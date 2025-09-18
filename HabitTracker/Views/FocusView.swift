// Views/FocusView.swift
import SwiftUI

struct FocusView: View {
    @State private var isFullScreenPresented = false //true se ve, false se cierra

    var body: some View {
        VStack {
            Button(action: { //iniciar el modo de enfoque
                withAnimation { //transición
                    isFullScreenPresented.toggle() //activa la vista en pantalla completa
                }
            }) {
                Text("Iniciar Enfoque")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .clipShape(Capsule())
            }
        }
        .fullScreenCover(isPresented: $isFullScreenPresented) { //vista del fullscreen si isFullScreenPresented es true
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.indigo, Color.purple]), //color degradado
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea() //cubra toda la pantalla

                VStack {
                    Spacer()
                    
                    Text("Modo Enfoque")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding()
                    
                    Button(action: { //botón para cerrar la vista
                        withAnimation {
                            isFullScreenPresented = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill") //botón con x dentro del círculo
                            .font(.largeTitle)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                }
            }
        }
    }
}

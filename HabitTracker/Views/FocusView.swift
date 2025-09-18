// Views/FocusView.swift
import SwiftUI

struct FocusView: View {
    @State private var isFullScreenPresented = false

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isFullScreenPresented.toggle()
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
        .fullScreenCover(isPresented: $isFullScreenPresented) {
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.indigo, Color.purple]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    Spacer()
                    
                    Text("Modo Enfoque")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding()
                    
                    Button(action: {
                        withAnimation {
                            isFullScreenPresented = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
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

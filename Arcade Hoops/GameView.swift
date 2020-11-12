//
//  ContentView.swift
//  Arcade Hoops
//
//  Created by Samuel Donovan on 10/15/20.
//

import SwiftUI
import RealityKit

struct GameView : View {
    
    @ObservedObject var gameManager = GameManager()
    
    var body: some View {
        ZStack {
            ARViewContainer(arView: gameManager.arView)
            VStack {
                Text("SCORE: \(gameManager.madeCount)")
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10.0).stroke().foregroundColor(.white))
                    .padding()
            Spacer()
            Button("SHOOT") {
                gameManager.shoot()
            }
            .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    let arView: ARView
    
    func makeUIView(context: Context) -> ARView {
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

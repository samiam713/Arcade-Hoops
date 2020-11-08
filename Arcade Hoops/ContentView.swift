//
//  ContentView.swift
//  Arcade Hoops
//
//  Created by Samuel Donovan on 10/15/20.
//

import SwiftUI
import RealityKit


struct BlurView: UIViewRepresentable {
    init(effect: UIBlurEffect.Style){
        self.effect = effect
    }
    let effect: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView(effect: UIBlurEffect(style: effect)) }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {}
}

struct RoundedBlurView: View {
    init(effect: UIBlurEffect.Style, cornerRadius: CGFloat) {
        self.effect = effect
        self.cornerRadius = cornerRadius
    }
    
    let effect: UIBlurEffect.Style
    let cornerRadius: CGFloat
    
    var body: some View {
        BlurView(effect: effect)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}


struct ContentView : View {
    
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

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

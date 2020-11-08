//
//  GameManager.swift
//  Arcade Hoops
//
//  Created by Samuel Donovan on 11/7/20.
//

import Foundation
import ARKit
import RealityKit
import Combine

let boxAnchor = try! Experience.loadBox()

class GameManager: ObservableObject {
    
    @Published var madeCount = 0
    
    let arView: ARView
    var sceneUpdate: AnyCancellable! = nil
    var collisionHappened: AnyCancellable! = nil
    
    var currentTime = 0.0
    let maxTime = 30.0
    
    enum GameState {
        case notStarted
        case playing
        case paused
        case finished
    }
    
    var gameState: GameState = .playing
    
    enum BallState {
        case inHands
        case inAir
        case hasCollided
    }
    
    var ballState: BallState = .inHands
    
    let ball: HasPhysics
    let player: Entity
    
    let triggerVolume: TriggerVolume
    
    init() {
        arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        arView.scene.addAnchor(boxAnchor)
        
        ball = boxAnchor.ball as! HasPhysics
        ball.physicsBody!.massProperties.mass = 1.0
        ball.physicsBody!.mode = .kinematic
        
        player = boxAnchor.player!
        
        triggerVolume = TriggerVolume(shape: ShapeResource.generateBox(size: [0.1,0.01,0.1]), filter: .default)
        boxAnchor.addChild(triggerVolume)
        triggerVolume.transform.translation = [0.0,0.36,-0.25]
        
        sceneUpdate = arView.scene.publisher(for: SceneEvents.Update.self).sink(receiveValue: everyFrame(frameUpdate:))
        collisionHappened = arView.scene.publisher(for: CollisionEvents.Began.self).sink(receiveValue: collisionEventBegan(collisionEvent:))
    }
    
    deinit {
        boxAnchor.removeChild(triggerVolume)
    }
    
    func collisionEventBegan(collisionEvent: CollisionEvents.Began) {
        let a = collisionEvent.entityA
        let b = collisionEvent.entityB
        
        if ballState == .inAir {
            if (a == triggerVolume || b == triggerVolume) && (a == ball || b == ball) {
                madeCount += 1
                print(madeCount)
                ballState = .hasCollided
            }
        }
    }
    
    func everyFrame(frameUpdate: Scene.Publisher<SceneEvents.Update>.Output) {
        let dt = frameUpdate.deltaTime
        
        switch gameState {
        case .notStarted: break
            
        case .playing:
            everyPlayingFrame(dt: dt)
        case .paused:
            break
        case .finished:
            break
        }
        
    }
    
    func everyPlayingFrame(dt: Double) {
        
        currentTime += dt
        
        if currentTime > maxTime {
            
        }
        
        let startingBallTranslation = [0.0,0.245,0.1754] as SIMD3<Float>
        let startingPlayerTranslation = [0.0,0.0,0.246] as SIMD3<Float>
        let max = [0.3,0.0,0.0] as SIMD3<Float>
        let period = 5.0 as Float
    
        let sideToSide = cos(Float(currentTime)*(2*Float.pi/period))*max
        
        let currentPlayerTranslation = startingPlayerTranslation + sideToSide
        
        player.transform.translation = currentPlayerTranslation
        
        // deal with ball
        
        switch ballState {
        case .inAir, .hasCollided:
            ball.applyLinearImpulse(Float(dt)*6*0.035*[0.0,-9.8,0.0], relativeTo: boxAnchor)
            if ball.transform.translation.y < 0.0375 {
                ballState = .inHands
                ball.physicsBody!.mode = .kinematic
            }
        case .inHands:
            ball.transform.translation = startingBallTranslation + sideToSide
        }
        
        // deal with player
        
    }
    
    func shoot() {
        print("Shot")
        
        ballState = .inAir
        ball.physicsBody!.mode = .dynamic
        
        let cos70: Float = 0.34202014332
        let sin70: Float = 0.93969262078
        let velocity: Float = 1.3
        
        let shootVector: SIMD3<Float> = velocity*[0.0,sin70,-cos70]
        
        // ball.physicsMotion!.linearVelocity = shootVector
        ball.applyLinearImpulse(shootVector, relativeTo: boxAnchor)
        
    }
    
    
}

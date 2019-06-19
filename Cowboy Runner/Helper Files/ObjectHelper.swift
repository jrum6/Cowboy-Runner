//
//  ObjectHelper.swift
//  Cowboy Runner
//
//  Created by Jack Margerum on 6/18/19.
//  Copyright © 2019 Jack Margerum. All rights reserved.
//

import SpriteKit

class ObjectHelper {
    
    static func handleChild(sprite: SKSpriteNode, with name: String) {
        
        switch name {
        case GameConstants.StringConstants.finishLineName, GameConstants.StringConstants.enemyName:
            PhysicsHelper.addPhysicsBody(to: sprite, with: name)
        default:
            break
        }
    }
}

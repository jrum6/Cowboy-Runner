//
//  AnimationHelper.swift
//  Cowboy Runner
//
//  Created by Jack Margerum on 6/17/19.
//  Copyright © 2019 Jack Margerum. All rights reserved.
//

import SpriteKit

class AnimationHelper {
    
    static func loadTextures(from atlas: SKTextureAtlas, withName name: String) -> [SKTexture]{
        var textures = [SKTexture]()
        for index in 0..<atlas.textureNames.count {
            let textureName = name + String(index)
            textures.append(atlas.textureNamed(textureName))
        }
        return textures
    }
}

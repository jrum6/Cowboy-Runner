//
//  PhysicsHelper.swift
//  Cowboy Runner
//
//  Created by Jack Margerum on 6/17/19.
//  Copyright © 2019 Jack Margerum. All rights reserved.
//

import SpriteKit

class PhysicsHelper {
    static func addPhysicsBody(to sprite: SKSpriteNode, with name: String) {
        switch name {
            //makes physics body for player
        case GameConstants.StringConstants.playerName:
            //initializes physics body
            sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width/2, height: sprite.size.height))
            //no bounce
            sprite.physicsBody!.restitution = 0.0
            //no rotation
            sprite.physicsBody!.allowsRotation = false
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.playerCategory
            sprite.physicsBody!.collisionBitMask = GameConstants.PhysicsCategories.groundCategory | GameConstants.PhysicsCategories.finishCategory
            sprite.physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.allCategory
        case GameConstants.StringConstants.finishLineName :
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.finishCategory
        case GameConstants.StringConstants.enemyName:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.enemyCategory
        default:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        }
        
        if name != GameConstants.StringConstants.playerName {
            sprite.physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.playerCategory
            sprite.physicsBody!.isDynamic = false
        }
    }
    
    static func addPhysicsBody(to tileMap: SKTileMapNode, and tileInfo: String){
        let tileSize = tileMap.tileSize
        
        for row in 0..<tileMap.numberOfRows {
            //turns ground tiles into physics bodies
            var tiles = [Int]()
            for col in 0..<tileMap.numberOfColumns {
                let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row)
                let isUsedTile = tileDefinition?.userData?[tileInfo] as? Bool
                if (isUsedTile ?? false) {
                    tiles.append(1)
                } else {
                    tiles.append(0)
                }
            }
            //turns platforms into physics bodies
            if tiles.contains(1) {
                var platform = [Int]()
                for (index, tile) in tiles.enumerated() {
                    if tile == 1 && index < (tileMap.numberOfColumns - 1) {
                        platform.append(index)
                    } else if !platform.isEmpty {
                        //print(platform)
                        let x = CGFloat(platform[0]) * tileSize.width
                        let y = CGFloat(row) * tileSize.height
                        let tileNode = GroundNode(with: CGSize(width: tileSize.width * CGFloat(platform.count), height: tileSize.height))
                        tileNode.position = CGPoint(x: x, y: y)
                        tileNode.anchorPoint = CGPoint.zero
                        tileMap.addChild(tileNode)
                        platform.removeAll()
                    }
                }
            }
        }
    }
}

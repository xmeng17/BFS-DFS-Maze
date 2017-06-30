//
//  GameScene.h
//  Maze
//
//  Created by xmeng17 on 12/28/16.
//  Copyright © 2016 xmeng17. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Node.h"
#import "Stack.h"
#import "Queue.h"
#import "math.h"

@interface GameScene : SKScene

@property NSMutableArray* MazeNode;
@property Node* start;
@property Node* goal;

@property NSMutableArray* MazeSprite;
@property SKSpriteNode* cow;
@property SKSpriteNode* present;

@property int MazeWidth;
@property int MazeHeight;


@end

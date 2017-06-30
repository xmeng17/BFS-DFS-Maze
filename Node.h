//
//  Node.h
//  Maze
//
//  Created by xmeng17 on 12/28/16.
//  Copyright © 2016 xmeng17. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

//yes stands for is path, no stands for wall
@property NSString* value;
@property Node* left;
@property Node* right;
@property Node* top;
@property Node* bottom;
@property Node* next;
@property Node* parent;
@property BOOL traveled;
@property int row;
@property int column;


-(instancetype)initWithValue:(NSString*)value;
-(instancetype)initWithData:(NSString*)value left:(Node*)left right:(Node*)right top:(Node*)top bottom:(Node*)bottom row:(int)row column:(int)column parent:(Node*)parent;

@end

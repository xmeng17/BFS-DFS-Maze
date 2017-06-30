//
//  Stack.h
//  Maze
//
//  Created by xmeng17 on 12/28/16.
//  Copyright © 2016 xmeng17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Stack : NSObject

@property Node* head;

-(instancetype)initWithNode:(Node*)node;
-(void)push:(Node*)node;
-(Node*)pop;

@end

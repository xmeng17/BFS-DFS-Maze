//
//  Node.m
//  Maze
//
//  Created by xmeng17 on 12/28/16.
//  Copyright © 2016 xmeng17. All rights reserved.
//

#import "Node.h"

@implementation Node


-(instancetype)initWithValue:(NSString *)value{
    self=[super init];
    self.value=value;
    self.left=nil;
    self.right=nil;
    self.top=nil;
    self.bottom=nil;
    self.next=nil;
    self.parent=nil;
    self.traveled=NO;
    self.row=-1;
    self.column=-1;
    return self;
}

-(instancetype)initWithData:(NSString*)value left:(Node*)left right:(Node*)right top:(Node*)top bottom:(Node*)bottom row:(int)row column:(int)column parent:(Node*)parent{
    self=[super init];
    self.value=value;
    self.left=left;
    self.right=right;
    self.top=top;
    self.bottom=bottom;
    self.next=nil;
    self.parent=nil;
    self.traveled=NO;
    self.row=row;
    self.column=column;
    self.parent=parent;
    return self;
}


@end

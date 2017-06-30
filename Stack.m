//
//  Stack.m
//  Maze
//
//  Created by xmeng17 on 12/28/16.
//  Copyright © 2016 xmeng17. All rights reserved.
//

#import "Stack.h"

@implementation Stack

-(instancetype)initWithNode:(Node*)node{
    self=[super init];
    self.head=[[Node alloc]initWithValue:@""];
    self.head.next=node;
    return self;
}

-(void)push:(Node*)node{
    
    Node* current=self.head;
    while(current.next){
        current=current.next;
    }
    current.next=node;
    

}
-(Node*)pop{
    Node* current=self.head;
    while(current.next.next){
        current=current.next;
    }
    Node* buffer=[[Node alloc]initWithData:current.next.value left:current.next.left right:current.next.right top:current.next.top bottom:current.next.bottom row:current.next.row column:current.next.column parent:current.next.parent];
    current.next=nil;
    return buffer;
    
}

@end

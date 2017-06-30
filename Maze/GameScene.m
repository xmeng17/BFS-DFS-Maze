//
//  GameScene.m
//  Maze
//
//  Created by xmeng17 on 12/28/16.
//  Copyright © 2016 xmeng17. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene 

- (void)didMoveToView:(SKView *)view {

    //open up the maze file
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"mediumMaze" withExtension:@"txt"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:[url path] encoding:NSUTF8StringEncoding error:&error];
    if (error){
        NSLog(@"Error reading file: %@", error.localizedDescription);
    }
    
    //seperate maze by returns, then set height and width
    self.MazeNode=(NSMutableArray*)[fileContents componentsSeparatedByString:@"\n"];
    [self.MazeNode removeLastObject];
    self.MazeHeight=(int)[self.MazeNode count];
    self.MazeWidth=(int)[[self.MazeNode objectAtIndex:0] length];
    
    //set each object of the maze to another NSMutableArray containing the Nodes
    for(int i=0;i<self.MazeHeight;i++){
        NSMutableArray* row=[[NSMutableArray alloc]init];
        for(int j=0;j<self.MazeWidth;j++){
            NSString* entry=[NSString stringWithFormat:@"%c",[[self.MazeNode objectAtIndex:i] characterAtIndex:j]];
            Node* node=[[Node alloc]initWithValue:entry];
            node.row=i;
            node.column=j;
            if([entry isEqualToString:@"S"]){
                self.start=node;
            }else if([entry isEqualToString:@"G"]){
                self.goal=node;
            }
            [row addObject:node];
        }
        [self.MazeNode replaceObjectAtIndex:i withObject:row];
    }
    //set up left,right,top,bottom for the center nodes
    for(int i=1;i<self.MazeHeight-1;i++){
        for(int j=1;j<self.MazeWidth-1;j++){
            Node* current=[[self.MazeNode objectAtIndex:i]objectAtIndex:j];
            current.left=[[self.MazeNode objectAtIndex:i]objectAtIndex:j-1];
            current.right=[[self.MazeNode objectAtIndex:i]objectAtIndex:j+1];
            current.top=[[self.MazeNode objectAtIndex:i-1]objectAtIndex:j];
            current.bottom=[[self.MazeNode objectAtIndex:i+1]objectAtIndex:j];
        }
    }

    //set up left,right,top,bottom for the edge nodes
    for(int i=1;i<self.MazeHeight-1;i++){
        //left most colomn
        Node* current=[[self.MazeNode objectAtIndex:i]objectAtIndex:0];
        current.right=[[self.MazeNode objectAtIndex:i]objectAtIndex:1];
        current.top=[[self.MazeNode objectAtIndex:i-1]objectAtIndex:0];
        current.bottom=[[self.MazeNode objectAtIndex:i+1]objectAtIndex:0];
        //right most colomn
        current=[[self.MazeNode objectAtIndex:i]objectAtIndex:self.MazeWidth-1];
        current.left=[[self.MazeNode objectAtIndex:i]objectAtIndex:self.MazeWidth-2];
        current.top=[[self.MazeNode objectAtIndex:i-1]objectAtIndex:self.MazeWidth-1];
        current.bottom=[[self.MazeNode objectAtIndex:i+1]objectAtIndex:self.MazeWidth-1];
    }
    for(int j=1;j<self.MazeWidth-1;j++){
        //top most row
        Node* current=[[self.MazeNode objectAtIndex:0]objectAtIndex:j];
        current.left=[[self.MazeNode objectAtIndex:0]objectAtIndex:j-1];
        current.right=[[self.MazeNode objectAtIndex:0]objectAtIndex:j+1];
        current.bottom=[[self.MazeNode objectAtIndex:1]objectAtIndex:j];
        //bottom most row
        current=[[self.MazeNode objectAtIndex:self.MazeHeight-1]objectAtIndex:j];
        current.left=[[self.MazeNode objectAtIndex:self.MazeHeight-1]objectAtIndex:j-1];
        current.right=[[self.MazeNode objectAtIndex:self.MazeHeight-1]objectAtIndex:j+1];
        current.top=[[self.MazeNode objectAtIndex:self.MazeHeight-2]objectAtIndex:j];
    }
    //set up left,right,top,bottom for the corner nodes
    //left-top
    Node* current=[[self.MazeNode objectAtIndex:0]objectAtIndex:0];
    current.right=[[self.MazeNode objectAtIndex:0]objectAtIndex:1];
    current.bottom=[[self.MazeNode objectAtIndex:1]objectAtIndex:0];
    //right-top
    current=[[self.MazeNode objectAtIndex:0]objectAtIndex:self.MazeWidth-1];
    current.left=[[self.MazeNode objectAtIndex:0]objectAtIndex:self.MazeWidth-2];
    current.bottom=[[self.MazeNode objectAtIndex:1]objectAtIndex:self.MazeWidth-1];
    //left-bottom
    current=[[self.MazeNode objectAtIndex:self.MazeHeight-1]objectAtIndex:0];
    current.right=[[self.MazeNode objectAtIndex:self.MazeHeight-1]objectAtIndex:1];
    current.top=[[self.MazeNode objectAtIndex:self.MazeHeight-2]objectAtIndex:0];
    //right-bottom
    current=[[self.MazeNode objectAtIndex:self.MazeHeight-1]objectAtIndex:self.MazeWidth-1];
    current.left=[[self.MazeNode objectAtIndex:self.MazeHeight-1]objectAtIndex:self.MazeWidth-2];
    current.top=[[self.MazeNode objectAtIndex:self.MazeHeight-2]objectAtIndex:self.MazeWidth-1];
    
    //create the MazeSprite
    self.MazeSprite=[[NSMutableArray alloc]init];
    for(int i=0;i<self.MazeHeight;i++){
        NSMutableArray* row=[[NSMutableArray alloc]init];
        for(int j=0;j<self.MazeWidth;j++){
            SKSpriteNode* sprite=[SKSpriteNode new];
            if([[[[self.MazeNode objectAtIndex:i]objectAtIndex:j]value]isEqualToString:@"#"]){
                sprite=[SKSpriteNode spriteNodeWithImageNamed:@"wall"];
                [sprite setXScale:0.17*8/(double)self.MazeWidth];
                [sprite setYScale:0.2*8/(double)self.MazeHeight];
            }else if([[[[self.MazeNode objectAtIndex:i]objectAtIndex:j]value ]isEqualToString:@"S"]){
                sprite=[SKSpriteNode spriteNodeWithImageNamed:@"cow"];
                self.cow=sprite;
                [sprite setZPosition:2];
                [sprite setXScale:8/(double)self.MazeWidth];
                [sprite setYScale:8/(double)self.MazeHeight];
            }else if([[[[self.MazeNode objectAtIndex:i]objectAtIndex:j]value ]isEqualToString:@"G"]){
                sprite=[SKSpriteNode spriteNodeWithImageNamed:@"present"];
                self.present=sprite;
                [sprite setZPosition:1];
                [sprite setXScale:8/(double)self.MazeWidth];
                [sprite setYScale:8/(double)self.MazeHeight];
            }
            [sprite setPosition:CGPointMake(view.frame.size.width*(-0.5+(double)j/(double)self.MazeWidth)*0.75,view.frame.size.height*(0.5-(double)i/(double)self.MazeHeight))];
            [row addObject:sprite];
            
        }
        [self.MazeSprite addObject:row];
    }
    
    //add a sprite for each entry
    for(int i=0;i<self.MazeHeight;i++){
        for(int j=0;j<self.MazeWidth;j++){
            [self addChild:[[self.MazeSprite objectAtIndex:i]objectAtIndex: j]];
        }
    }

    
    //solve maze
    [self BreadthFirstSearch:view ];
    //[self DepthFirstSearch:view];
}

-(void)BreadthFirstSearch:(SKView *)view {
    //init
    Queue* queue=[[Queue alloc]initWithNode:self.goal];
    [self.goal setTraveled:YES];
    BOOL keeplooping=YES;
    
    //BFS
    while(queue.head.next!=nil&&keeplooping){
        //get item from stack
        Node* current=[queue dequeue];
        NSArray* adjacent=[NSArray arrayWithObjects:current.left,current.right,current.top,current.bottom, nil];
        for(int i=0;i<4;i++){
            //get adjacent
            Node* adj=[adjacent objectAtIndex:i];
            if(!adj.traveled){
                if([adj.value isEqualToString:@"."]){
                    [adj setParent:current];
                    [adj setTraveled:YES];
                    [queue enqueue:adj];
                }else if([adj.value isEqualToString:@"S"]){
                    [adj setParent:current];
                    [adj setTraveled:YES];
                    keeplooping=NO;
                    
                }
            }
            
        }
    }
    //Find shortest path
    Node* current=self.start;
    
    CGMutablePathRef path=CGPathCreateMutable();
    double xDestiny=self.cow.position.x;
    double yDestiny=self.cow.position.y;
    CGPathMoveToPoint(path,NULL,xDestiny, yDestiny);
    
    while(current){
        xDestiny=view.frame.size.width*(-0.5+(double)current.column/(double)self.MazeWidth)*0.75;
        yDestiny=view.frame.size.height*(0.5-(double)current.row/(double)self.MazeHeight);
        CGPathAddLineToPoint(path, NULL, xDestiny, yDestiny);
        current=current.parent;
    }
    
    //Draw!
    SKAction *Move = [SKAction followPath:path asOffset:NO orientToPath:NO duration:MAX(self.MazeHeight,self.MazeWidth)/1.5];
     [self.cow runAction:Move];

}

-(void)DepthFirstSearch:(SKView *)view {
    
    Stack* stack=[[Stack alloc]initWithNode:self.goal];
    [self.goal setTraveled:YES];
    BOOL keeplooping=YES;
    
    //DFS
    while(stack.head.next!=nil&&keeplooping){
        //get item from stack
        Node* current=[stack pop];
        NSArray* adjacent=[NSArray arrayWithObjects:current.left,current.right,current.top,current.bottom, nil];
        for(int i=0;i<4;i++){
            //get adjacent
            Node* adj=[adjacent objectAtIndex:i];
            if(!adj.traveled){
                if([adj.value isEqualToString:@"."]){
                    [adj setParent:current];
                    [adj setTraveled:YES];
                    [stack push:adj];
                }else if([adj.value isEqualToString:@"S"]){
                    [adj setParent:current];
                    [adj setTraveled:YES];
                    keeplooping=NO;
                    
                }
            }
            
        }
    }
    //Find shortest path
    Node* current=self.start;
    
    CGMutablePathRef path=CGPathCreateMutable();
    double xDestiny=self.cow.position.x;
    double yDestiny=self.cow.position.y;
    CGPathMoveToPoint(path,NULL,xDestiny, yDestiny);
    
    while(current){
        xDestiny=view.frame.size.width*(-0.5+(double)current.column/(double)self.MazeWidth)*0.75;
        yDestiny=view.frame.size.height*(0.5-(double)current.row/(double)self.MazeHeight);
        CGPathAddLineToPoint(path, NULL, xDestiny, yDestiny);
        current=current.parent;
    }
    
    //Draw!
    SKAction *Move = [SKAction followPath:path asOffset:NO orientToPath:NO duration:MAX(self.MazeHeight,self.MazeWidth)/1.5];
    [self.cow runAction:Move];

    
    
    
    
}



-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end

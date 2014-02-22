//
//  Bunny.h
//  BoucyBall
//
//  Created by Eric Muxagata on 2/21/14.
//  Copyright (c) 2014 Eric Muxagata. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "BouncyConstants.h"

@interface Bunny : CCNode

@property (nonatomic, readonly) CCSprite *sphere;
@property (nonatomic) int direction;


-(CGPoint)defaultVelocity;
-(instancetype)init;

@end

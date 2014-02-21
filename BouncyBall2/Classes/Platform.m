//
//  Platform.m
//  BoucyBall
//
//  Created by Eric Muxagata on 2/21/14.
//  Copyright (c) 2014 Eric Muxagata. All rights reserved.
//

#import "Platform.h"

@implementation Platform

+(instancetype)platformWithRectangle:(CGRect)rect {
    return [[Platform alloc] initWithRectangle:rect];
}

-(instancetype)initWithRectangle:(CGRect)rect {
    self = [super init];
    if(!self) return nil;
    
    _sprite = [EMSpriteHelper createSpriteRectangleWithSize:rect];
    [self addChild:_sprite];
    
    CCPhysicsBody *body = [CCPhysicsBody bodyWithRect:rect cornerRadius:0];
    self.physicsBody = body;
    body.type = CCPhysicsBodyTypeStatic;
    body.collisionGroup = BouncyThickPlatformGroup;
    body.collisionType  = BouncyThickPlatformCollision;
    body.elasticity = BouncyPlatformElasticity;

    return self;
}

@end

//
//  Bunny.m
//  BoucyBall
//
//  Created by Eric Muxagata on 2/21/14.
//  Copyright (c) 2014 Eric Muxagata. All rights reserved.
//

#import "Bunny.h"

@implementation Bunny {
    BOOL _grabbed;
    NSTimeInterval _previousTime;
    CGPoint _previousVelocity;
    CGPoint _previousPos;
    CGPoint _defaultVelocity;
}


-(CGPoint)defaultVelocity {
    return _defaultVelocity;
}


-(instancetype)init {
    self = [super init];
    if(!self) return nil;
    
    _sphere = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"letter.o.png"]];
    _sphere.scale = 0.5f;
    [self addChild:_sphere];

    CCPhysicsBody *body = [CCPhysicsBody bodyWithCircleOfRadius:(_sphere.contentSize.width) *_sphere.scale*0.5 andCenter:CGPointZero];
    self.physicsBody = body;
    
    body.collisionGroup = BouncySphereGroup;
    body.collisionType = BouncySphereCollision;
    body.elasticity = BouncyBunnyElasticity;
    
    _sphere.color = [CCColor whiteColor];
    
    
    _defaultVelocity = ccp(2*_sphere.contentSize.width*_sphere.scale, _sphere.contentSize.width*_sphere.scale);
    
    self.userInteractionEnabled = YES;
    
    return self;

}

// touch handlers are just so i can play with him

- (BOOL)hitTestWithWorldPos:(CGPoint)pos
{
    CGPoint nodePos = [self convertToNodeSpace:pos];
    
    float distance = ccpLength(nodePos);
    return(distance < _sphere.contentSize.width * 0.5);
}



- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{

    CGPoint parentPos = [_parent convertToNodeSpace:touch.locationInWorld];
    
    self.physicsBody.mass = NewtonSphereMovingMass;

    _grabbed = YES;
    _previousVelocity = CGPointZero;
    _previousTime = event.timestamp;
    _previousPos = parentPos;
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint parentPos = [_parent convertToNodeSpace:touch.locationInWorld];
    
    // on each move, calculate a velocity used in update, and save new state data
    _previousVelocity = ccpMult( ccpSub(parentPos, _previousPos), 1 / (event.timestamp - _previousTime));
    _previousTime = event.timestamp;
    _previousPos = parentPos;
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    _grabbed = NO;
    self.physicsBody.mass = NewtonSphereNormalMass;
}

- (void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self touchEnded:touch withEvent:event];
}


- (void)update:(CCTime)delta
{
    if (_grabbed)
    {
        self.position = _previousPos;
        self.physicsBody.velocity = _previousVelocity;
        
    } else {
    
        self.physicsBody.velocity = ccp(_defaultVelocity.x,self.physicsBody.velocity.y);
    
    }
    
}


@end

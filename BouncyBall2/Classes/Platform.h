//
//  Platform.h
//  BoucyBall
//
//  Created by Eric Muxagata on 2/21/14.
//  Copyright (c) 2014 Eric Muxagata. All rights reserved.
//

#import "cocos2d.h"
#import "EMSpriteHelper.h"
#import "BouncyConstants.h"

@interface Platform : CCNode

@property (nonatomic,readonly) CCSprite *sprite;

+(instancetype) platformWithRectangle:(CGRect)rect;
-(instancetype) initWithRectangle:(CGRect)rect;

@end

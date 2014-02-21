//
//  EMLevelBuilder.m
//  BouncyBall2
//
//  Created by Eric Muxagata on 2/21/14.
//  Copyright (c) 2014 Eric Muxagata. All rights reserved.
//

#import "EMLevelBuilder.h"
#import "Platform.h"

@implementation EMLevelBuilder



+(NSMutableArray *)buildDummyLevel:(CGSize)screenSize {

    NSMutableArray *platforms = [[NSMutableArray alloc] init];
    
    
    CGPoint centerPos = ccp(screenSize.width*0.5, screenSize.height*0.5);
    CGFloat _offset = 0.1*screenSize.width;
        
    Platform *p = [Platform platformWithRectangle:CGRectMake(centerPos.x - _offset, centerPos.y - _offset, 0.25*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x + _offset, centerPos.y, 0.15*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - _offset, centerPos.y, 0.05*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - 4*_offset, centerPos.y + 2*_offset, 0.5*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x + 2*_offset, centerPos.y, 0.05*screenSize.width, 0.25*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - 2*_offset, centerPos.y - 2*_offset, 0.25*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - 3*_offset, centerPos.y - 3*_offset, 0.25*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];

    return platforms;

}

@end

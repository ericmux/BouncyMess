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
    CGPoint _offset = ccp(0.5*0.15*screenSize.width,0.05*screenSize.height);
        
    Platform *p = [Platform platformWithRectangle:CGRectMake(centerPos.x - _offset.x, centerPos.y - _offset.y, 0.15*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - 2*_offset.x, centerPos.y - 2*_offset.y, 0.15*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x, centerPos.y - 2*_offset.y, 0.15*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x + 2*_offset.x, centerPos.y - 5*_offset.y, 0.15*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - 3*_offset.x, centerPos.y - 5*_offset.y, 0.15*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x + 4*_offset.x, centerPos.y - 5*_offset.y, 0.05*screenSize.width, 0.35*screenSize.height)];
    [platforms addObject:p];

    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - 4*_offset.x, centerPos.y - 6*_offset.y, 0.15*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - 5*_offset.x, centerPos.y - 7*_offset.y, 0.15*screenSize.width, 0.05*screenSize.height)];
    [platforms addObject:p];

    return platforms;

}

@end

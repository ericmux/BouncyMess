#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "EMSpriteHelper.h"

@implementation EMSpriteHelper


+(CCSprite*) createSpriteRectangleWithSize:(CGRect)rect
{
    CCSprite *sprite = [CCSprite node];
    GLubyte *buffer = malloc(sizeof(GLubyte)*4);
    for (int i=0;i<4;i++) {buffer[i]=255;}
    CCTexture *tex = [[CCTexture alloc] initWithData:buffer pixelFormat:CCTexturePixelFormat_RGB5A1 pixelsWide:1 pixelsHigh:1 contentSizeInPixels:rect.size contentScale:1.0];
    [sprite setTexture:tex];
    [sprite setTextureRect:rect];
    [sprite setAnchorPoint:ccp(0,0)];
    [sprite setPosition:rect.origin];
    [sprite setColor:[CCColor blackColor]];
    
    free(buffer);
    return sprite;
}


@end

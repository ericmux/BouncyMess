#import "BouncyScene.h"
#import "BouncyConstants.h"
#import "NewtonSphere.h"
#import "Bunny.h"
#import "Platform.h"
#import "EMSpriteHelper.h"
#import "EMLevelBuilder.h"


@implementation BouncyScene
{
    CCPhysicsNode *_physics;
    CGSize _screenSize;
    CGPoint _previous_velocity;
    BOOL _trapped;
}

+ (instancetype)scene
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (!self) return(nil);
     
    _screenSize = [CCDirector sharedDirector].viewSize;
    
    glClearColor(222.0f/255, 237.0f/255, 244.0f/255, 1.0);
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"newton.plist"];
    
    CGPoint centerPos = ccp(_screenSize.width * 0.5, _screenSize.height * 0.5);
    
    // add a reset button
    CCButton *resetButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"reset.png"]];
    resetButton.positionType = CCPositionTypeNormalized;
    resetButton.position = NewtonButtonResetPosition;
    [resetButton setTarget:self selector:@selector(onResetClicked:)];
    [self addChild:resetButton];
    
    // Create a physics node, to hold all the spheres
    // This node is a physics node, so that you can add physics to the spheres
    _physics = [CCPhysicsNode node];
    _physics.gravity = NewtonGravity;
    _physics.collisionDelegate = (NSObject<CCPhysicsCollisionDelegate> *) self;
    [self addChild:_physics];
    
    NSMutableArray *level  = [EMLevelBuilder buildDummyLevel:_screenSize];
    
    for(Platform *p in level){
        [_physics addChild:p];
    }
    
    
	CGRect worldRect = CGRectMake(0, 0, [CCDirector sharedDirector].viewSize.width, [CCDirector sharedDirector].viewSize.height);
    CCNode *outline = [CCNode node];
    outline.physicsBody = [CCPhysicsBody bodyWithPolylineFromRect:worldRect cornerRadius:0];
    outline.physicsBody.friction = 0;
    outline.physicsBody.elasticity = 1;
    outline.physicsBody.collisionGroup = BouncyThickPlatformGroup;
    outline.physicsBody.collisionType = BouncyThickPlatformCollision;
    [_physics addChild:outline];
    
    Bunny *bunny = [[Bunny alloc] init];
    bunny.position = ccp(centerPos.x, centerPos.y + 0.1*centerPos.y);
    [_physics addChild:bunny];
    
    self.userInteractionEnabled = YES;
    _trapped = NO;

	return self;
}

- (void)onEnter
{
    [super onEnter];
}

- (void)onExit
{
    [super onExit];
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
}

- (void)onExitTransitionDidStart
{
    [super onExitTransitionDidStart];
}


- (void)onResetClicked:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[BouncyScene scene]];
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"The background was touched");
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair sphereCollision:(CCNode *)bunny thickPlatformCollision:(CCNode *)platform {
    _previous_velocity = bunny.physicsBody.velocity;
    return YES;
}

- (BOOL)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair sphereCollision:(Bunny *)bunny thickPlatformCollision:(Platform *)platform {

    BOOL isUnder = bunny.position.y + bunny.contentSize.height*0.8 <= platform.position.y;
    BOOL isAbove = bunny.position.y + bunny.contentSize.height*0.5 >= platform.position.y + platform.contentSize.height;
    BOOL isHittingSide = bunny.position.x + bunny.contentSize.width*0.8 >= platform.position.x || bunny.position.x <= platform.position.x + platform.contentSize.width;
    if(_trapped) _trapped = isHittingSide;

    if(isUnder){
        bunny.physicsBody.velocity = ccp(_previous_velocity.x,-_previous_velocity.y);
        return YES;
    }
    
    if(isAbove){
        bunny.physicsBody.velocity = ccp(_previous_velocity.x, bunny.defaultVelocity.y);
        return YES;
    }
    
    if(isHittingSide && !_trapped){
        bunny.physicsBody.velocity = ccp(-bunny.defaultVelocity.x, _previous_velocity.y);
        bunny.direction = -bunny.direction;
        _trapped = YES;
        return YES;
    }

    return NO;
}


@end

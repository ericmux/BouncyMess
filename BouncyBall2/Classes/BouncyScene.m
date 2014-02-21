#import "BouncyScene.h"
#import "BouncyConstants.h"
#import "NewtonSphere.h"
#import "Bunny.h"
#import "Platform.h"
#import "EMSpriteHelper.h"


@implementation BouncyScene
{
    CCPhysicsNode *_physics;
    CGSize _screenSize;
    CGPoint _previous_velocity;
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
    
    CGFloat _offset = 0.1*_screenSize.width;
        
    Platform *p = [Platform platformWithRectangle:CGRectMake(centerPos.x - _offset, centerPos.y - _offset, 0.25*_screenSize.width, 0.05*_screenSize.height)];
    [_physics addChild:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x + _offset, centerPos.y, 0.15*_screenSize.width, 0.05*_screenSize.height)];
    [_physics addChild:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - _offset, centerPos.y, 0.05*_screenSize.width, 0.05*_screenSize.height)];
    [_physics addChild:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - 4*_offset, centerPos.y + 2*_offset, 0.5*_screenSize.width, 0.05*_screenSize.height)];
    [_physics addChild:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x + 2*_offset, centerPos.y, 0.05*_screenSize.width, 0.25*_screenSize.height)];
    [_physics addChild:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - 2*_offset, centerPos.y - 2*_offset, 0.25*_screenSize.width, 0.05*_screenSize.height)];
    [_physics addChild:p];
    
    p = [Platform platformWithRectangle:CGRectMake(centerPos.x - 3*_offset, centerPos.y - 3*_offset, 0.25*_screenSize.width, 0.05*_screenSize.height)];
    [_physics addChild:p];
    
    
	CGRect worldRect = CGRectMake(0, 0, [CCDirector sharedDirector].viewSize.width, [CCDirector sharedDirector].viewSize.height);
    CCNode *outline = [CCNode node];
    outline.physicsBody = [CCPhysicsBody bodyWithPolylineFromRect:worldRect cornerRadius:0];
    outline.physicsBody.friction = 0;
    outline.physicsBody.elasticity = 1;
    outline.physicsBody.collisionGroup = BouncyThickPlatformGroup;
    outline.physicsBody.collisionType = BouncyThickPlatformCollision;
    [_physics addChild:outline];
    
    
    for (int index = 0; index < 2; index ++)
    {
        NewtonSphere *sphere = [NewtonSphere newtonSphereWithLetter:(NSString *)NewtonLetter[index]];
        sphere.position = ccpAdd(centerPos, ccpMult(NewtonLetterPosition[index], sphere.sphere.contentSize.width - NewtonSphereMargin + NewtonSphereSpacing));
        [_physics addChild:sphere];
    }
    
    Bunny *bunny = [[Bunny alloc] init];
    bunny.position = centerPos;
    [_physics addChild:bunny];
    
    self.userInteractionEnabled = YES;

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
    _previous_velocity.y = -_previous_velocity.y;
    return YES;
}

- (BOOL)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair sphereCollision:(Bunny *)bunny thickPlatformCollision:(CCNode *)platform {
    bunny.physicsBody.velocity = _previous_velocity;
    return YES;
}


@end



static const int NewtonLetterCount = 7;
static const NSString *NewtonLetter[] = { @"c", @"o", @"c", @"o", @"s", @"2", @"d" };
static const CGPoint NewtonLetterPosition[] = {{-2,0}, {-1,0}, {0,0}, {1,0}, {2,0}, {1.8,-2}, {2.8,-2}};

static const CGPoint NewtonButtonResetPosition = (CGPoint){0.90f, 0.90f};

static const CGPoint NewtonGravity = (CGPoint){0, -980.665};
static const float NewtonSphereElasticity = 1.0f;

static const float NewtonSphereNormalMass = 1;
static const float NewtonSphereSwingingMass = 0.25;
static const float NewtonSphereMovingMass = 100;


static const float NewtonParticleScale = 0.8f;
static const float NewtonParticleDisplacement = 0.35f;

// Added because the image of the sprite doesnt fill the image 100%
// A transparent blended margin is kept, to make the image looks good then it rotates.
static const float NewtonSphereMargin = 3;
static const float NewtonSphereSpacing = 3;

static const NSString *NewtonSphereCollisionSphere = @"sphere";
static const NSString *NewtonSphereCollisionOutline = @"outline";
static const NSString *NewtonSphereCollisionRope = @"rope";

static NSString * const BouncySphereCollision = @"sphereCollision";
static NSString * const BouncyThickPlatformCollision = @"thickPlatformCollision";
static NSString * const BouncySphereGroup = @"sphere";
static NSString * const BouncyThickPlatformGroup = @"thickPlatform";

static const float BouncyPlatformElasticity = 1.0f;
static const float BouncyBunnyElasticity = 1.0f;


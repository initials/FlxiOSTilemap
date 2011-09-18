@implementation FlxSpriteOnPath

@synthesize limitX;
@synthesize limitY;

@synthesize pathSpeed;

BOOL requiresXMovement;
BOOL requiresYMovement;
int _movementType;


+ (id) flxSpriteOnPathWithOrigin:(CGPoint)Origin withSpeed:(float)Speed  withLimits:(CGPoint)Limits  withMovementType:(int)MovementType
{
	return [[[self alloc] initWithOrigin:Origin withSpeed:Speed withLimits:CGPointMake(Limits.x, Limits.y)  withMovementType:MovementType] autorelease];
}

- (id) initWithOrigin:(CGPoint)Origin withSpeed:(float)Speed   withLimits:(CGPoint)Limits  withMovementType:(int)MovementType
{
	if ((self = [super initWithX:Origin.x y:Origin.y graphic:nil])) {
        originalXPos = Origin.x;
        originalYPos = Origin.y;
        limitX = Limits.x;
        limitY = Limits.y;
        _movementType = MovementType;
        
        //movement type 1 : moving from the start
        //movement type 2 : wait until block is jumped on
        
//        if (YES) {
            if (originalXPos==limitX) {
                self.velocity = CGPointMake(0, Speed);
            } else  if (originalYPos==limitY) {
                self.velocity = CGPointMake(Speed, 0);
            }
            else {
                self.velocity = CGPointMake(Speed, Speed);
            }
//        }
//        else {
//            self.velocity = CGPointMake(0, 0);
//        }
        
	}
	
	return self;	
}

- (void) dealloc
{
	
	[super dealloc];
}

- (void) advancePath
{
    if (limitX!=originalXPos) {
        if (self.x >= limitX ) {    
            self.x = limitX-1;
            CGFloat i = self.velocity.x * -1;
            self.velocity = CGPointMake(i, self.velocity.y);
        } else if (self.x <= originalXPos) {
            self.x = originalXPos+1;
            CGFloat i = self.velocity.x * -1;
            self.velocity = CGPointMake(i, self.velocity.y);        
        }
    }
    //else { self.velocity = CGPointMake(self.velocity.x, 0); }
    if (limitY!=originalYPos) {
        if (self.y >= limitY ) {    
            self.y = limitY-1;
            CGFloat ii = self.velocity.y * -1;
            self.velocity = CGPointMake(self.velocity.x, ii);
        } else if (self.y <= originalYPos) {
            self.y = originalYPos+1;
            CGFloat ii = self.velocity.y * -1;
            self.velocity = CGPointMake(self.velocity.x, ii);        
        }
    }
    //else { self.velocity = CGPointMake(0, self.velocity.y); }

    
    
    
}


//- (void) hitTopWithParam1:(FlxObject *)Contact param2:(float)Velocity
//{
//    _movementType=1;
//    [super hitRightWithParam1:Contact param2:Velocity];
//}





- (void) update
{   
    [self advancePath];
    
    //NSLog(@" %d", _movementType);
    
	[super update];
	
}


@end

//
//  MenuState.m
//  Canabalt
//
//  Copyright Semi Secret Software 2009-2010. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "FlxHelloWorldState.h"
#import "FlxImageInfo.h"

@implementation FlxHelloWorldState

- (id) init
{
  if ((self = [super init])) {
    self.bgColor = 0xffcdd9ee;
  }
  return self;
}

- (void) create
{
  helloText = [FlxText textWithWidth:FlxG.width
								text:@"FlxTileMap by Initials"
								font:nil
								size:26.0];
  helloText.color = 0xffffffff;
  helloText.alignment = @"center";
  helloText.x = 0;
  helloText.y = 15;
  [self add:helloText];

			   
    [self loadLevelBlocksFromImage];

    
}

- (void) loadLevelBlocksFromImage {
    static NSString * ImgTiles;
    
    NSData* pixelData;
    
    ImgTiles = @"level1_tiles.png";
    pixelData = [FlxImageInfo readImage:@"level1_map.png"];
    
    
    int levelWidth = 480 / 10;
    int levelHeight = 320 / 10;
    
    //    static NSString * ImgTiles = @"level1_tiles.png";
    //    NSData* pixelData = [FlxImageInfo readImage:@"level1_map.png"];
    
    unsigned char* pixelBytes = (unsigned char *)[pixelData bytes];
    
    int j = 0;
    
    int arbID=0;
    
    for(int i = 0; i < [pixelData length]; i += 4) {
        
        int red1 = pixelBytes[i];
        int green1 = pixelBytes[i+1];
        int blue1 = pixelBytes[i+2];
        int alpha1 = pixelBytes[i+3];
        
        //if pixel has some red and some green
        if (pixelBytes[i]>0 && pixelBytes[i+1]>0 && pixelBytes[i+2]<100 && pixelBytes[i+3]==255) {
            //NSLog(@"Found a red+blue Pixel");
            int w = pixelBytes[i]*10;
            int h = pixelBytes[i+1]*10;
            bl = [FlxTileblock tileblockWithX:( (j)%levelWidth)*10 y:((j) / levelWidth) * 10 width:w height:h];  
            [bl loadGraphic:ImgTiles 
                    empties:0 
                   autoTile:YES 
             isSpeechBubble:0 
                 isGradient:0 
                arbitraryID:blue1
                      index:arbID] ;
            
            bl.originalXPos = ((j)%levelWidth)*10;
            bl.originalYPos = ((j) / levelWidth) * 10;
            
            [self add:bl]; 
            
            arbID++;
        }
        
        
        
        
        
        //NSLog(@"PIXEL DATA %d %hhu %hhu %hhu %hhu %d %d", i, pixelBytes[i], pixelBytes[i+1], pixelBytes[i+2], pixelBytes[i+3], (j%48)*10, (j / 48) * 10 );
        j++;
    }
    
}


- (void) dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];

  [super dealloc];
}


- (void) update
{
  
  
  [super update];

  
}


@end


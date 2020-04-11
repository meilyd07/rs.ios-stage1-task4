#import "FullBinaryTrees.h"

@interface FullBinaryTrees()
@property (strong, nonatomic) NSMutableDictionary *nodesDictionary;
@end

@implementation FullBinaryTrees
- (instancetype)init
{
    self = [super init];
    if (self) {
        _nodesDictionary = [NSMutableDictionary new];
    }
    return self;
}

- (NSString *)stringForNodeCount:(NSInteger)count {
    return [self binaryToString:count];
}

- (NSString *) binaryToString:(NSInteger)count {
    NSArray *inputArray = [self arrayOfPossibleFBT:count];
    
    NSMutableString *resultString = [NSMutableString new];
    [resultString appendString:@"["];
    
    NSInteger countTrees = [inputArray count];
    for(NSInteger i = 0; i < countTrees; i++) {
        
        [resultString appendString:@"["];
        if ([inputArray[i][0] isKindOfClass:[NSNumber class]]) {//root
            [resultString appendString:@"0"];
        }
        
        if (![inputArray[i][1] isKindOfClass:[NSNull class]]) {//left
            [resultString appendString:@",0,0"];// 2 or null children
            for (int s = 1; s <= 2; s++) {
                for (int j = 1; j <= 2; j++) {
                    if ([inputArray[i][s][j] isKindOfClass:[NSNull class]]) {
                        [resultString appendString:@",null"];
                    } else {
                        [resultString appendString:@",0"];
                    }
                }
                
                for (int m = 1; m <= 2; m++) {
                    if (![inputArray[i][s][m] isKindOfClass:[NSNull class]]) {
                        for (int k = 1; k <= 2; k++) {
                            if ([inputArray[i][s][m][k] isKindOfClass:[NSNull class]]) {//left
                                [resultString appendString:@",null"];
                            } else {
                                [resultString appendString:@",0"];
                            }
                        }
                    }
                }
                
                for (int n = 1; n <= 2; n++) {
                    if (![inputArray[i][s][n] isKindOfClass:[NSNull class]]) {
                        for (int d = 1; d <= 2; d++) {
                            if (![inputArray[i][s][n][d] isKindOfClass:[NSNull class]]) {
                                for (int c = 1; c <= 2; c++) {
                                    if ([inputArray[i][s][n][d][c] isKindOfClass:[NSNull class]]) {//left
                                        [resultString appendString:@",null"];
                                    } else {
                                        [resultString appendString:@",0"];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        NSRange range = [resultString rangeOfString:@"0" options:NSBackwardsSearch];
        if (range.location < resultString.length - 1) {
            [resultString replaceCharactersInRange:NSMakeRange(range.location + 1, [resultString length] - range.location - 1) withString:@""];
        }
        [resultString appendString:@"]"];
    }
    
    [resultString appendString:@"]"];
    return resultString;
}

- (NSArray *)arrayOfPossibleFBT:(NSInteger)countNodes {
    if (![self.nodesDictionary objectForKey:@(countNodes).stringValue]) {
        NSMutableArray *possible = [NSMutableArray new];
        if (countNodes == 1) {
            NSArray *treeNode = @[@0, [NSNull null], [NSNull null]];
            [possible addObject:treeNode];
            
        } else if (countNodes % 2 == 1){
            for (int x = 0; x < countNodes; ++x) {
                NSInteger y = countNodes - 1 - x;
                
                NSArray *left = [self arrayOfPossibleFBT:x];
                NSArray *right = [self arrayOfPossibleFBT:y];
                
                for (NSArray* l in left) {
                    for (NSArray* r in right) {
                        NSArray *node = @[@0, l, r];
                        [possible addObject:node];
                    }
                }
            }
        }
        self.nodesDictionary[@(countNodes).stringValue] = possible;
    }
    return self.nodesDictionary[@(countNodes).stringValue];
}
@end

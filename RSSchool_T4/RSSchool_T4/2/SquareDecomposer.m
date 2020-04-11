#import "SquareDecomposer.h"

@implementation SquareDecomposer
- (NSMutableArray<NSNumber*>*)decomposeNumber:(NSInteger)current AndRemaining:(NSInteger)rest {
    if (rest == 0) {
        NSMutableArray <NSNumber*>* resultArray = [NSMutableArray new];
        [resultArray addObject:@(current)];
        return resultArray;
    }
    
    //foreach number less than current
    for (NSInteger i = current - 1; i > 0; i--){
        if ((rest - i * i) >= 0) {
            NSMutableArray <NSNumber*>* resultArray = [self decomposeNumber:i AndRemaining:(rest - i * i)];
            
            if (resultArray != nil) {
                [resultArray addObject:@(current)];
                return resultArray;
            }
        }
    }
    
    return nil;
}

- (NSArray <NSNumber*>*)decomposeNumber:(NSNumber*)number {
    
    NSInteger intNumber = [number integerValue];
    NSMutableArray<NSNumber*> *decomposeArray = [[self decomposeNumber:intNumber AndRemaining:(intNumber*intNumber)] mutableCopy];
    if (decomposeArray != nil) {
        [decomposeArray removeLastObject];
        return decomposeArray;
    }
    return nil;
}

@end

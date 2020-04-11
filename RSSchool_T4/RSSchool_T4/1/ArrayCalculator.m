#import "ArrayCalculator.h"

@implementation ArrayCalculator
+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"self isKindOfClass: %@",
                              [NSNumber class]];
    NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
    NSInteger filteredCount = [filteredArray count];
    if (filteredCount > 0) {
        
        NSArray *sortedArray = [filteredArray sortedArrayUsingFunction:sortAbs context:NULL];
        NSInteger result = 1;
        
        if (numberOfItems >= [sortedArray count]) {
            for (NSNumber *item in sortedArray) {
                result *= [item integerValue];
            }
            return result;
        } else {
            
            //multiple last n numbers
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"intValue >= 0"];
            NSMutableArray * positiveNumbers = [[sortedArray filteredArrayUsingPredicate:predicate] mutableCopy];
            
            if (([positiveNumbers count] == 0) && (numberOfItems % 2)) {
                //all negative and odd number to multiply
                sortedArray = [[sortedArray reverseObjectEnumerator] allObjects];
            }
            
            NSInteger lastNegativeIndex = -1;
            
            for (NSInteger i = 0; i < numberOfItems; i++) {
                NSNumber *objectToMultiply = [sortedArray objectAtIndex:i];
                result *= [objectToMultiply integerValue];
                
                [positiveNumbers removeObject:objectToMultiply]; //removed already used
                if ([objectToMultiply intValue] < 0) {
                    lastNegativeIndex = i;
                }
            }
            
            if ((result < 0) && (lastNegativeIndex >= 0) && ([positiveNumbers count] > 0)) {
                result = result / [sortedArray[lastNegativeIndex] integerValue] * [[positiveNumbers firstObject] integerValue];
            }
            
            
            return result;
        }
    } else {
        return 0;
    }
}

NSInteger sortAbs(id num1, id num2, void *context)
{
    int v1 = abs([num1 intValue]);
    int v2 = abs([num2 intValue]);

    if (v1 < v2)      return NSOrderedDescending;
    else if (v1 > v2) return NSOrderedAscending;
    else              return NSOrderedSame;
}
@end

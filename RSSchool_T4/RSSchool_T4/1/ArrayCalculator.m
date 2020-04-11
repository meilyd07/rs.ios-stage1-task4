#import "ArrayCalculator.h"

@implementation ArrayCalculator
+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
    @"self isKindOfClass: %@",
    [NSNumber class]];
    NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
    NSInteger filteredCount = [filteredArray count];
    if (filteredCount > 0) {
    
        NSMutableArray *sortedArray = [[filteredArray sortedArrayUsingFunction:sortAbs context:NULL] mutableCopy];

        int result = 1;
        
        if (numberOfItems >= [sortedArray count]) {
            for (NSNumber *item in sortedArray) {
                result *= [item integerValue];
            }
            return result;
        } else {
//            NSArray *subArray = [sortedArray subarrayWithRange:NSMakeRange(0, numberOfItems)];
//            for (NSInteger i = 0; i < numberOfItems; i++) {
//                result *= [[sortedArray objectAtIndex:i] integerValue];
//            }
//            if (result < 0) {
//                
//                NSPredicate * predicateNegativeValues = [NSPredicate predicateWithFormat:@"integerValue < 0"];
//                NSArray * negativeNumbersArray = [sortedArray filteredArrayUsingPredicate:predicate];
//            }
            
//            NSPredicate * predicateNegativeValues = [NSPredicate predicateWithFormat:@"integerValue < 0"];
//            NSArray * negativeNumbersArray = [sortedArray filteredArrayUsingPredicate:predicate];
//            NSInteger countOfNegativeNumbers = [negativeNumbersArray count];
            
//            if ((countOfNegativeNumbers > 0) && !(countOfNegativeNumbers % 2))
//            while (result < 0) {
//                <#statements#>
//            }
            
            //multiple last n numbers
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"integerValue >= 0"];
            NSArray * positiveNumbers = [sortedArray filteredArrayUsingPredicate:predicate];
            int positiveResult = 1;
            
            for (NSInteger i = 0; i < numberOfItems; i++) {
                result *= [[sortedArray objectAtIndex:i] integerValue];
                positiveResult *= [[positiveNumbers objectAtIndex:i] integerValue];
            }
            
            return (result > positiveResult) ? result : positiveResult;
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

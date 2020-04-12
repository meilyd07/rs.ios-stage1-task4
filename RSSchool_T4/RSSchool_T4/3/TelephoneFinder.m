#import "TelephoneFinder.h"

@implementation TelephoneFinder
- (NSArray <NSString*>*)findAllNumbersFromGivenNumber:(NSString*)number {
    
    if ([number integerValue] < 0) {
        return nil;
    }
    
    NSDictionary *adjacentDictionary = @{ @"0" : @[@"8"],
                                          @"1" : @[@"2", @"4"],
                                          @"2" : @[@"1", @"3", @"5"],
                                          @"3" : @[@"2", @"6"],
                                          @"4" : @[@"1", @"5", @"7"],
                                          @"5" : @[@"2", @"4", @"6", @"8"],
                                          @"6" : @[@"3", @"5", @"9"],
                                          @"7" : @[@"4", @"8"],
                                          @"8" : @[@"5", @"7", @"9", @"0"],
                                          @"9" : @[@"6", @"8"]
    };
    
    NSMutableArray<NSString *> *resultPhoneNumbers = [NSMutableArray new];
    
    for (int i = 0; i < [number length]; i++) {
        NSString *iChar  = [NSString stringWithFormat:@"%c", [number characterAtIndex:i]];

        //find array in dictionary
        NSArray *dictionaryArray = adjacentDictionary[iChar];
        for (int j = 0; j < [dictionaryArray count]; j++) {
            NSString *phoneString = [number stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:dictionaryArray[j]];
            [resultPhoneNumbers addObject:phoneString];
        }
    }
    
    return resultPhoneNumbers;
}
@end

//
//  ViewController.m
//  ClassroomNSArray
//
//  Created by Dmitriy Tarelkin on 12/4/18.
//  Copyright © 2018 Dmitriy Tarelkin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //create pool
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
    
    //1 Create NSArray, containing several strings, using literal declaration.
    NSArray *arrayOfStrings = @[@"srting1", @"string2", @"string3",@"string4"]; //will be autoreleased and go to pool
    
    //2 Create mutable array from piviously created NSArray.
    NSMutableArray* mutArray = [[NSMutableArray arrayWithArray:arrayOfStrings] mutableCopy];
    
    ///////////////////releasing objects//////////////////////////////////////
    [mutArray release];
    [pool drain]; //release "autoreleased" objects: arrayOfStrings
    
    
    
    //3 Create an empty array and obtain its first and last element in a safe way.
    NSArray* emptyArray = [NSArray array];
    [emptyArray firstObject];
    [emptyArray lastObject];
    NSLog(@"Empty array: %@, %@", [emptyArray firstObject],[emptyArray lastObject]);
    
    //////////////////////releasing emptyArray from pool//////////////////////
    [pool drain];
    
    
    //4 Create NSArray, containing strings from 1 to 20:
    NSArray* arrWithTwentyStrings = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                                      @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"]; //will be autoreleased
    
    
    //Shallow copy
    NSMutableArray* newArr = [arrWithTwentyStrings copyWithZone:nil];
    //arrWithTwentyStrings = [arrWithTwentyStrings initWithArray:arrWithTwentyStrings copyItems:YES];
    
    NSLog(@"Shallow :%@", [newArr componentsJoinedByString:@","]);
    
    //real deep copy
    NSArray* deepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:newArr]] ;
    
    NSLog(@"Deep: %@",[deepCopyArray componentsJoinedByString:@","]);
    
    //////////////////releasing objects/////////////////////////
    [newArr release];
    [pool drain];   // releasing of arrWithTwentyStrings
    // deepCopyArray is still using
    
    
    
    //5 Iterate over array and obtain item at index 13. Print an item.
    //first way
    for (int index = 0; index < deepCopyArray.count; index += 1) {
        if (index == 13) {
            NSLog(@"object %@ with index %d", [deepCopyArray objectAtIndex:index], index);
        }
    }
    //second way
    [deepCopyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL* stop) {
        if (index == 13) {
            NSLog(@"object found : %@ at index %lu",obj, (unsigned long)index);
            *stop =YES;
        }
    }];
    
    //6 Make array mutable. Add two new entries to the end of the array, add an entry to the beginning of the array. Iterate over an array and remove item at index 5.
    
    /*
     id one = @"first"; //with NSString* - crash
     
     id makeMutableArray = (NSMutableArray*)[deepCopyArray mutableCopy];
     
     //don't compile with addObject:
     makeMutableArray = [makeMutableArray arrayByAddingObject:firstEntrie];  //rewrite array with new appended object
     makeMutableArray = [makeMutableArray arrayByAddingObject:secondEntrie]; //rewrite array with new appended object
     
     // makeMutableArray = [makeMutableArray insertObject:one atIndex:0]; -- don't work
     
     //another way to entry object at first place
     makeMutableArray = [@[one] arrayByAddingObjectsFromArray:makeMutableArray];
     
     NSLog(@"%@", makeMutableArray);
     
     if ([makeMutableArray isKindOfClass:[NSMutableArray class]]) {
     NSLog(@"it's real mutable");
     }
     */
    
    NSMutableArray* mArray = [deepCopyArray mutableCopy];
    
    [mArray addObject:[NSString stringWithFormat:@"appendEntry1"]];
    [mArray addObject:[NSString stringWithFormat:@"appendEntry2"]];
    [mArray insertObject:[NSString stringWithFormat:@"beginEntry"] atIndex:0];
    
    NSLog(@"Added entries: %@", [mArray componentsJoinedByString:@"-"]);
    
    //removing object at index 5
    [mArray enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL* stop) {
        if (index == 5) {
            NSLog(@"Remove object: %@ at index %lu",obj, (unsigned long)index);
            [mArray removeObjectAtIndex:index];
            *stop =YES;
        }
    }];
    NSLog(@"Array: %@", [mArray componentsJoinedByString:@"-"]);
    
    
    //release mArray and deepCopyArray
    [mArray release];
    [pool drain]; //releasing deepCopyArray
    
    
    
    
    //7 Create new array of mixed numbers. Sort it in an ascending and descending order.
    NSArray* arrayWithNumbers = @[[NSNumber numberWithInteger:-12],
                                  [NSNumber numberWithDouble:23.123f],
                                  [NSNumber numberWithFloat:112.433f],
                                  [NSNumber numberWithUnsignedInteger:34],
                                  [NSNumber numberWithBool:1]];     //will be autoreleased in pool
    
    NSLog(@"arrayWithNumbers: %@",[arrayWithNumbers componentsJoinedByString:@","]);  //this array will fall into pool
    
    //ascending
    arrayWithNumbers = [arrayWithNumbers sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber* first = obj1;
        NSNumber* second = obj2;
        return [first compare:second];
    }];
    NSLog(@"In ascending order %@",[arrayWithNumbers componentsJoinedByString:@" --> "]);
    
    //descending
    arrayWithNumbers = [arrayWithNumbers sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber* first = obj1;
        NSNumber* second = obj2;
        return [second compare:first];
    }];
    
    NSLog(@"In descending order %@",[arrayWithNumbers componentsJoinedByString:@" <-- "]);
    
    //releasing arrayWithNumbers - don't need to be released because of autoreleasing later
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

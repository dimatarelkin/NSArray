//
//  AppDelegate.m
//  ClassroomNSArray
//
//  Created by Dmitriy Tarelkin on 12/4/18.
//  Copyright © 2018 Dmitriy Tarelkin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//1 Create NSArray, containing several strings, using literal declaration.
    NSArray *arrayOfStrings = @[@"srting1", @"string2", @"string3",@"string4"];
    
//2 Create mutable array from piviously created NSArray.
    NSMutableArray* mutArray = [NSMutableArray arrayWithArray:arrayOfStrings];
    
    
//3 Create an empty array and obtain its first and last element in a safe way.
    NSArray* emptyArray = [NSArray array];
    [emptyArray firstObject];
    [emptyArray lastObject];
    NSLog(@"%@, %@", [emptyArray firstObject],[emptyArray lastObject]);
    
//4 Create NSArray, containing strings from 1 to 20:
    NSArray* arrWithTwentyStrings = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                                      @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
    
    for (NSString* str in arrWithTwentyStrings) {
        NSLog(@"%ld",(long)&str);
    }
    
//Shallow copy
    NSMutableArray* newArr = [arrWithTwentyStrings copyWithZone:nil];
    //arrWithTwentyStrings = [arrWithTwentyStrings initWithArray:arrWithTwentyStrings copyItems:YES];
    
    
    NSLog(@"%@", newArr);
//real deep copy
    NSArray* deepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:newArr]];
    NSLog(@"ddddddeeeeeep %@",deepCopyArray);
    
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
    
    NSString* firstEntrie = @"appendEntrie1";
    NSString* secondEntrie = @"appendEntrie2";
    NSString* one = @"first";
    
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
    [mArray addObject:firstEntrie];
    [mArray addObject:secondEntrie];
    [mArray insertObject:one atIndex:0];
    NSLog(@"%@", mArray);
    
//removing object at index 5
    
    [mArray enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL* stop) {
        if (index == 5) {
            NSLog(@"remove object: %@ at index %lu",obj, (unsigned long)index);
            [mArray removeObjectAtIndex:index];
            *stop =YES;
        }
    }];
    
    NSLog(@"%@", mArray);
    
//7 Create new array of mixed numbers. Sort it in an ascending and descending order.
    NSArray* arrayWithNumbers = @[[NSNumber numberWithInteger:-12],
                                         [NSNumber numberWithDouble:23.123f],
                                         [NSNumber numberWithFloat:112.433f],
                                         [NSNumber numberWithUnsignedInteger:34],
                                         [NSNumber numberWithBool:1]];
    NSLog(@"%@",arrayWithNumbers);
   
 //ascending
    arrayWithNumbers = [arrayWithNumbers sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber* first = obj1;
        NSNumber* second = obj2;
        return [first compare:second];
    }];
    NSLog(@"sorted array in ascending order %@",[arrayWithNumbers componentsJoinedByString:@" --> "]);
    
//descending
    arrayWithNumbers = [arrayWithNumbers sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber* first = obj1;
        NSNumber* second = obj2;
        return [second compare:first];
    }];
    NSLog(@"sorted array in descending order %@",[arrayWithNumbers componentsJoinedByString:@" <-- "]);

  
    
    
    
    
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

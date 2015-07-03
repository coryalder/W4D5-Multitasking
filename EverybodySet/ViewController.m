//
//  ViewController.m
//  EverybodySet
//
//  Created by Cory Alder on 2015-07-02.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>

@interface Juggler: NSObject

@property (nonatomic, strong) NSString *leftHandItem;
@property (nonatomic, strong) NSString *rightHandItem;

- (void)swapLeftAndRightHandItems;
- (NSString *)juggleNewItem:(NSString *)item; // return dropped item

@end

@implementation Juggler

//-(void)setLeftHandItem:(NSString *)leftHandItem {
//
//
//}
//
//-(void)setRightHandItem:(NSString *)rightHandItem {
//
//}

- (void)swapLeftAndRightHandItems {
    NSString *oldLeftHandItem = self.leftHandItem;
    self.leftHandItem = self.rightHandItem;
    self.rightHandItem = oldLeftHandItem;
}

- (NSString *)juggleNewItem:(NSString *)item {
    NSString *retval = self.rightHandItem;
    self.rightHandItem = item;
    [self swapLeftAndRightHandItems];
    return retval;
}

@end


@interface ViewController () {
    int counter;
}

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation ViewController


- (IBAction)concurrentAction:(id)sender {
    
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    
//    
//    for (int i = 0; i < 100; i++) {
//        dispatch_async(queue, ^{
//            counter++;
//            NSLog(@"i is %i", i);
//        });
//    }
//
    
    
    // what would we use concurrency for?
    
    // NETWORKING!!!
    // IMAGE PROCESSING
    
    
    //// GAMES
    
    //
//    
//    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
//       
//        UIImage *image = [[UIImage alloc] initWithContentsOfFile:<#(NSString *)#>];
//        
//        // apply filter to image
//        
//        
//        // go to main thread
//        // show in imageView
//        
//        
//    }];
    
    
    
//    [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
//        
//    }]];
//    
//    
//    
//    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
//    
//    
//    [context performBlock:^{
//       // save core data
//        NSLog(@"0");
//    }];
//    
//    __block NSArray *myArray = nil;
//    
//    [context performBlockAndWait:^{
//        NSLog(@"1");
//       myArray = // get data from core data;
//    }];
//    
//    
//    for (id item in myArray) {
//    
//    
//    }
//    NSLog(@"2");
    
    
//    
//    __weak id weakSelf = self;
//    self.counter = 1;
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if ([weakSelf counter]) {
//        
//        } else {
//            
//        }
//        
//        NSLog(@"ten seconds happened");
//    });
//    
//    self.counter = 0;
    // example of a race condition:
    
//    dispatch_queue_t queue = dispatch_queue_create("com.cory.queue", DISPATCH_QUEUE_CONCURRENT);
//
////    NSLock *lock = [[NSLock alloc] init];
//    
//    for (int i = 0; i < 100; i++) {
//        dispatch_async(queue, ^{
//            // counter
//            NSLog(@"int is %i", i);
//        });
//    }
//    
    
    // example of concurrent operations
    
//    dispatch_queue_t q1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t q2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//    dispatch_queue_t q3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//    dispatch_queue_t q4 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
//    
//    
//    Juggler * juggler = [[Juggler alloc] init];
//    
//    void (^asyncBlock)() = ^{
//            for (int i = 0 ; i < 1000; i++) {
//                [juggler swapLeftAndRightHandItems];
//                [juggler juggleNewItem:[NSString stringWithFormat:@"%i", i]];
//            }
//        NSLog(@"Finished . Current left: %@, right: %@",
//              juggler.leftHandItem, juggler.rightHandItem);
//    };
//    
//    dispatch_async(q1, asyncBlock);
//    dispatch_async(q2, asyncBlock);
//    dispatch_async(q3, asyncBlock);
//    dispatch_async(q4, asyncBlock);
    
    
// race condition using NSOperationQueues
// also, nsoperation dependencies
    
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    myQueue.maxConcurrentOperationCount = 1;
    myQueue.name = @"coolBackgroundQueue";
    
    NSBlockOperation *completionBlock = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Done counting");
    }];
    
    
    for (int i = 0; i < 100; i++) {
        NSBlockOperation *countBlock = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"NSOperationQueue i is %i", i);
        }];
        
        [completionBlock addDependency:countBlock];
        [myQueue addOperation:countBlock];
    }
    
    [myQueue addOperation:completionBlock];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

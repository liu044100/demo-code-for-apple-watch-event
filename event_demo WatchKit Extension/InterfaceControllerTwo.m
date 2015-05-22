
//
//  InterfaceControllerTwo.m
//  event_demo
//
//  Created by yuchen liu on 5/22/15.
//  Copyright (c) 2015 rain. All rights reserved.
//

#import "InterfaceControllerTwo.h"

@interface InterfaceControllerTwo ()

@end

@implementation InterfaceControllerTwo

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}
- (IBAction)sendToHostHeavy {
    NSDictionary *info = @{@"info":@"すごく眠い"};
    [WKInterfaceController openParentApplication:info reply:nil];
}
- (IBAction)sendToHost {
    NSDictionary *info = @{@"info":@"眠い"};
    [WKInterfaceController openParentApplication:info reply:nil];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end




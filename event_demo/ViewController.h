//
//  ViewController.h
//  event_demo
//
//  Created by yuchen liu on 5/22/15.
//  Copyright (c) 2015 rain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end


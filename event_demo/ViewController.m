//
//  ViewController.m
//  event_demo
//
//  Created by yuchen liu on 5/22/15.
//  Copyright (c) 2015 rain. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSUUID *proximityUUID;
@property (nonatomic) CLBeaconRegion *beaconRegion;


@end

@implementation ViewController

- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse || kCLAuthorizationStatusDenied");
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }else if (status == kCLAuthorizationStatusAuthorized){
        NSLog(@"kCLAuthorizationStatusAuthorized!!!");
        [self.locationManager startMonitoringForRegion:self.beaconRegion];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataSource = [NSMutableArray new];
    
    if ([CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.proximityUUID = [[NSUUID alloc] initWithUUIDString:@"854F03E4-3311-4DF8-82E1-CAF3F171B162"];
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.proximityUUID identifier:@"event.self.demo"];
        self.beaconRegion.notifyOnExit = NO;
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
            [self requestAlwaysAuthorization];
        }else{
            [self.locationManager startMonitoringForRegion:self.beaconRegion];
        }
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *data = self.dataSource[indexPath.row];
    
    cell.textLabel.text = data[0];
    cell.detailTextLabel.text = data[1];
    
    return cell;
}

-(void)sendLocalNotificationForMessage:(NSString*)message{
    UILocalNotification *localNotification = [UILocalNotification new];
    localNotification.alertBody = message;
    localNotification.fireDate = [NSDate date];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    //for show in apple watch
    localNotification.alertTitle = @"江頭2:50";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void)fetchData{
     [self sendLocalNotificationForMessage:@"うたた寝している場合ではないよ〜"];
}

#pragma mark - CLLocationManagerDelegate methods

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    NSLog(@"didDetermineState");
    if (state == CLRegionStateInside) {
        NSLog(@"user already inside");
        [self fetchData];
    }
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"didEnterRegion");
    
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

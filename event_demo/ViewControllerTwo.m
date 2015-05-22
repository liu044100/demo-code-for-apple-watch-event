//
//  ViewControllerTwo.m
//  event_demo
//
//  Created by yuchen liu on 5/22/15.
//  Copyright (c) 2015 rain. All rights reserved.
//

#import "ViewControllerTwo.h"

@interface ViewControllerTwo ()
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation ViewControllerTwo

- (IBAction)downLoadData:(id)sender {
    self.updateButton.enabled = NO;

    [self fetchData];
}

-(void)updateUI{
    
    self.dataLabel.text = [NSString stringWithFormat:@"%@", self.dataDic];
}

-(void)fetchData{
    
    if (self.dataTask) {
        [self.dataTask cancel];
        self.dataTask = nil;
    }
    
    self.dataTask = [self.session dataTaskWithURL:[NSURL URLWithString:@"http://ec2-52-68-208-72.ap-northeast-1.compute.amazonaws.com/result/2"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            self.dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", self.dataDic);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.updateButton.enabled = YES;
                [self updateUI];
            });
        }else{
            NSLog(@"error -> %@", error.localizedDescription);
        }
    }];
    
    [self.dataTask resume];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    self.session = [NSURLSession sessionWithConfiguration:config];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  AKViewController.m
//  AKIndexView
//
//  Created by Ahmed Khalaf on 07/27/2018.
//  Copyright (c) 2018 Ahmed Khalaf. All rights reserved.
//

#import "AKViewController.h"
@import AKIndexView;

@interface AKViewController () <AKIndexViewDataSource, AKIndexViewDelegate>

@end

@implementation AKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AKIndexViewDataSource

- (NSInteger)numberOfRowsInIndexView:(AKIndexView *)indexView {
    return 30;
}

- (UIView *)indexView:(AKIndexView *)indexView viewForRow:(NSInteger)row {
    UILabel* label = [[UILabel alloc] init];
    label.text = @(row).stringValue;
    label.font = [UIFont systemFontOfSize:10];
    
    return label;
}

#pragma mark - AKIndexViewDelegate

@end

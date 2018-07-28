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

@property(nonatomic, weak) IBOutlet AKIndexView* indexView;
@property(nonatomic) NSArray<NSString*>* data;
@property(nonatomic) NSInteger selectedRow;

@end

@implementation AKViewController

- (NSArray<NSString *> *)data {
    if (_data == nil) {
        NSMutableArray<NSString*>* mData = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i <= 30; i++) {
            [mData addObject:@(i).stringValue];
        }
        _data = [[NSArray alloc] initWithArray:mData];
    }
    
    return _data;
}

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
    return self.data.count;
}

- (UIView *)indexView:(AKIndexView *)indexView viewForRow:(NSInteger)row {
    UILabel* label = [[UILabel alloc] init];
    label.text = self.data[row];
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    
    if (self.selectedRow == row) {
        label.backgroundColor = [UIColor redColor];
        label.textColor = [UIColor purpleColor];
    } else {
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
    }
    
    return label;
}

#pragma mark - AKIndexViewDelegate

- (void)indexView:(AKIndexView *)indexView didSelectRow:(NSInteger)row {
    self.selectedRow = row;
    [self.indexView reloadData];
}

@end

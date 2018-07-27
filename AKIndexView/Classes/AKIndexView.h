//
//  AKIndexView.h
//  AKIndexView
//
//  Created by Ahmed Khalaf on 7/28/18.
//

#import <UIKit/UIKit.h>

@protocol AKIndexViewDataSource;
@protocol AKIndexViewDelegate;

@interface AKIndexView : UIView

@property(nonatomic, weak, nullable) IBOutlet id<AKIndexViewDataSource> dataSource;
@property(nonatomic, weak, nullable) IBOutlet id<AKIndexViewDelegate> delegate;

- (void)reloadData;

@end


@protocol AKIndexViewDataSource <NSObject>

- (NSInteger)numberOfRowsInIndexView:(AKIndexView*_Nonnull)indexView;
- (UIView*_Nonnull)indexView:(AKIndexView*_Nonnull)indexView viewForRow:(NSInteger)row;

@end

@protocol AKIndexViewDelegate <NSObject>

/// Axis for the underlying stackview.
- (UILayoutConstraintAxis)axisForIndexView:(AKIndexView*_Nonnull)indexView;

/// Distribution for the underlying stackview.
- (UIStackViewDistribution)distributionForIndexView:(AKIndexView*_Nonnull)indexView;

/// Alignment for the underlying stackview.
- (UIStackViewAlignment) alignmentForIndexView:(AKIndexView*_Nonnull)indexView;

- (void)indexView:(AKIndexView*_Nonnull)indexView didSelectRow:(NSInteger)row;

@end

//
//  AKIndexView.m
//  AKIndexView
//
//  Created by Ahmed Khalaf on 7/28/18.
//

#import "AKIndexView.h"

#define AKIVAxisOrElse(elseValue) (self.delegate != nil && [self.delegate respondsToSelector:@selector(axisForIndexView:)] ? [self.delegate axisForIndexView:self] : elseValue)
#define AKIVDistributionOrElse(elseValue) (self.delegate != nil && [self.delegate respondsToSelector:@selector(distributionForIndexView:)] ? [self.delegate distributionForIndexView:self] : elseValue)
#define AKIVAlignmentOrElse(elseValue) (self.delegate != nil && [self.delegate respondsToSelector:@selector(alignmentForIndexView:)] ? [self.delegate alignmentForIndexView:self] : elseValue)
#define AKIVRecognizeOutOfBoundsPans (self.delegate != nil && [self.delegate respondsToSelector:@selector(recognizeOutOfBoundsPansInIndexView:)] ? [self.delegate recognizeOutOfBoundsPansInIndexView:self] : YES)


@interface AKIndexView()

@property(nonatomic) UIStackView* stackView;

@end

@implementation AKIndexView

- (void)setupViews {
    self.stackView = [[UIStackView alloc] init];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.stackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.leadingAnchor constraintEqualToAnchor:self.stackView.leadingAnchor],
        [self.trailingAnchor constraintEqualToAnchor:self.stackView.trailingAnchor],
        [self.topAnchor constraintEqualToAnchor:self.stackView.topAnchor],
        [self.bottomAnchor constraintEqualToAnchor:self.stackView.bottomAnchor]
    ]];
    
    UIPanGestureRecognizer* panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
    [self.stackView addGestureRecognizer:panGR];
    UITapGestureRecognizer* tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
    [self.stackView addGestureRecognizer:tapGR];
                                     
}

- (void)gestureRecognized:(UIGestureRecognizer*)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self];
    
    if (AKIVRecognizeOutOfBoundsPans) {
        location.x = CGRectGetMidX(self.stackView.bounds);
    }
    
    NSInteger rows = [self.dataSource numberOfRowsInIndexView:self];
    for (NSInteger i = 0; i < rows; i++) {
        UIView* view = self.stackView.arrangedSubviews[i];
        if (CGRectContainsPoint(view.frame, location)) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(indexView:didSelectRow:)]) {
                [self.delegate indexView:self didSelectRow:i];
            }
        }
    }
}

- (void)reloadData {
    
    for (UIView* view in self.stackView.arrangedSubviews) {
        [view removeFromSuperview];
    }
    
    self.stackView.axis = AKIVAxisOrElse(UILayoutConstraintAxisVertical);
    self.stackView.distribution = AKIVDistributionOrElse(UIStackViewDistributionFillEqually);
    self.stackView.alignment = AKIVAlignmentOrElse(UIStackViewAlignmentFill);

    
    NSInteger rows = [self.dataSource numberOfRowsInIndexView:self];
    for (NSInteger i = 0; i < rows; i++) {
        UIView* viewForRow = [self.dataSource indexView:self viewForRow:i];
        NSAssert1(viewForRow != nil, @"Supplied view for row: %ld should'nt be nil.", i);
        
        [self.stackView addArrangedSubview:viewForRow];
    }
}

#pragma mark - Overrides

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)didMoveToWindow {
    
    // Reload data as the view is added to a window (is about to be visible).
    if (self.window) {
        [self reloadData];
    }
}

@end

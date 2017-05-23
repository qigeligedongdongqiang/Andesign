//
//  StretchableTableHeaderView.h
//  StretchableTableHeaderView
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HFStretchableTableHeaderView : NSObject

@property (nonatomic,retain) UITableView* tableView;
@property (nonatomic,retain) UIImageView* imageView;

- (void)stretchHeaderForTableView:(UITableView*)tableView withHeaderView:(UIView*)view bgImage:(UIImage *)image;
- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

@end

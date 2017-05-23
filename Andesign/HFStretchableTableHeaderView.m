//
//  StretchableTableHeaderView.m
//  StretchableTableHeaderView
//

#import "HFStretchableTableHeaderView.h"

@interface HFStretchableTableHeaderView()
{
    CGRect initialFrame;
    CGFloat defaultViewWidth;
    CGFloat defaultViewHeight;
}
@end


@implementation HFStretchableTableHeaderView

- (void)stretchHeaderForTableView:(UITableView*)tableView withHeaderView:(UIView*)view bgImage:(UIImage *)image {
    _tableView = tableView;
    initialFrame = view.frame;
    defaultViewWidth = initialFrame.size.width;
    defaultViewHeight = initialFrame.size.height;
    UIImageView* bgImageView = [[UIImageView alloc] initWithFrame:initialFrame];
    bgImageView.image = image;
    _imageView = bgImageView;
    [_tableView addSubview:_imageView];
    _tableView.tableHeaderView  = view;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    if(scrollView.contentOffset.y < 0) {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        initialFrame.origin.x = offsetY * -1/2;
        initialFrame.origin.y = offsetY * -1;
        initialFrame.size.height = defaultViewHeight + offsetY;
        initialFrame.size.width = defaultViewWidth + offsetY;
        _imageView.frame = initialFrame;
    }
}

@end

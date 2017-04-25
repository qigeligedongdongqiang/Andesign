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

- (void)stretchHeaderForTableView:(UITableView*)tableView withView:(UIView*)view
{
    _tableView = tableView;
    _view = view;
    initialFrame = _view.frame;
    defaultViewWidth = initialFrame.size.width;
    defaultViewHeight = initialFrame.size.height;
    UIView* emptyTableHeaderView = [[UIView alloc] initWithFrame:initialFrame];
    _tableView.tableHeaderView   = emptyTableHeaderView;
    [_tableView addSubview:_view];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if(scrollView.contentOffset.y < 0) {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        initialFrame.origin.x = offsetY * -1/2;
        initialFrame.origin.y = offsetY * -1;
        initialFrame.size.height = defaultViewHeight + offsetY;
        initialFrame.size.width = defaultViewWidth + offsetY;
        _view.frame = initialFrame;
    }
}

@end

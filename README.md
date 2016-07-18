# XYHKeyBoardTableView
本文的产生主要是因为业务的需求，我在做电商app时，需要在购物车的确认订单界面，添加买家留言功能，设计在每一个订单的尾部都加了一个输入框，用于买家留言。设计效果图如下:

![Simulator Screen Shot 2016年5月14日 下午2.44.05.png](http://upload-images.jianshu.io/upload_images/908053-526e921df6038fc9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 这样就涉及到了一个问题，那就是有多个订单的时候，在切换留言输入的时候，需要将当前的输入框滚动到键盘的上方，取其中一个视觉上最佳的位置；之前传统的做法是记录每次点击的cell的indexPath，然后调用
```
[tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
```
但在我已经成型的结构中，由于cell中只包含商品信息，其中还有邮费和总价，包括这个留言板都在放在sectionFooterView中的，所以这种方式并不能够满足我的需求。
经过几番周折，想到iOS中UIView的坐标转换，我可以通过坐标转换获取当前textView相对于tableView的实际位置，采用
```
[textView convertRect:textView.frame toView:self.tableView]
```
方法就可以获取textView在tableview中的实际位置。在实际开发的过程中，发现我需要在监听键盘响应通知前，就要获取textView的绝对位置，因此我在textView的代理方法中，用一个全局的CGRect来接受当前textView的绝对fram:
```
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.currentTextViewRect = [textView convertRect:textView.frame toView:self];
    return YES;
}
```
紧接着就这在键盘通知方发中去调整tableView的偏移量
```
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    //取出键盘最终的frame
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //取出键盘弹出需要花费的时间
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //获取最佳位置距离屏幕上方的距离
    /**
     *这个距离是有相对偏移位置 - 屏幕上方空余高度的偏移量
     */
    if ((self.currentTextViewRect.origin.y + self.currentTextViewRect.size.height) >  ([UIScreen mainScreen].bounds.size.height - rect.size.height)) {//键盘的高度 高于textView的高度 需要滚动
        [UIView animateWithDuration:duration animations:^{
            self.contentOffset = CGPointMake(0, self.currentTextViewRect.origin.y + self.currentTextViewRect.size.height - ([UIScreen mainScreen].bounds.size.height - rect.size.height));
        }];
    }
}
```
注意的是，在设置偏移位置时，我们的目标是让键盘挡住的textView可以完整的出现在键盘的上方，并且当前输入的textView离键盘最近，所以在设计调整位置的时候，我首先获取当前textView绝对fram，为了textView显示全，需要在self.currentTextViewRect的Y值加上他自身的高度，得到的这个值并不是，我最终的偏移量，因为它会把当前textView滚动到屏幕上方，因此我们需要在这个值的基础上减去当前屏幕的空白高度（屏幕高度-键盘高度）。
至此，我就得到了，我最终想要的位置，并且还可以在
```
self.currentTextViewRect.origin.y + self.currentTextViewRect.size.height + constant
```
加上一个数值，以达到一个比较满意的位置。

在此，我来展示一下我完成的效果图，喜欢的朋友求star✨，就当是给点我继续下去的动力。第一次完整的写文章，如有好的意见，求留言。

![keyTableView.gif](http://upload-images.jianshu.io/upload_images/908053-7187a1ce1ab199ac.gif?imageMogr2/auto-orient/strip)

# WHC_Layout (Swift)
<div align=center><img src="https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/WHC_AutoLayoutLogo.png" width = "319.5" height = "129"/></div></br>

![Build Status](https://api.travis-ci.org/netyouli/WHC_Layout.svg?branch=master)
[![Pod Version](http://img.shields.io/cocoapods/v/WHC_Layout.svg?style=flat)](http://cocoadocs.org/docsets/WHC_Layout/)
[![Platform](https://img.shields.io/cocoapods/p/SnapKit.svg?style=flat)](https://github.com/SnapKit/SnapKit)
[![Pod License](http://img.shields.io/cocoapods/l/WHC_Layout.svg?style=flat)](https://opensource.org/licenses/MIT)

-  iOS and Mac OS X platforms currently in use the fastest the simplest development to build the UI layout automatically open source library, strong dynamic layout constraint handling capacity
-  Service to update constraints, convenient and quick dynamic UI layout.

**Objective-c version** 👉 [WHC_AutoLayout](https://github.com/netyouli/WHC_AutoLayoutKit)

Introduce
==============
-  Adopt chain layout Api calls convenient
-  Include one line of code to calculate UITableViewCell highly module
-  Contains WHC_StackView module (UIStackView purpose alternative system)
-  Automatic identification of the same type conflict and update the new constraints
-  Support change constraints priority
-  Support delete constraints
-  Support iOS and Mac OS X
-  Automatic covering and modify the conflict with type constraints

Require
==============
* iOS 8.0+ / Mac OS X 10.11+ / tvOS 9.0+
* Xcode 8.0 or later
* Swift 3.0+

Install
==============
* CocoaPods: pod 'WHC_Layout'

Usage
==============

## Automatic height view
![](https://github.com/netyouli/WHC_Layout/blob/master/Gif/autoHeight.gif)

```swift
view.whc_Left(10)
    .whc_Top(10)
    .whc_Right(10)
    .whc_HeightAuto()
```

## Use lessEqual or greaterEqual (width <= 100 && width >= 20)
```swift
view.whc_Width(100).whc_LessOrEqual()
    .whc_Width(20).whc_GreaterOrEqual()
```

## SnapKit/Masonry update the constraint way unfriendly
```swift
view.snp.updateConstraints {(make) -> Void in
    make.top.equalTo(superview.snp_top).with.offset(10) 
    make.left.equalTo(superview.snp_left).with.offset(20)
    make.bottom.equalTo(superview.snp_bottom).with.offset(-10)
    make.right.equalTo(superview.snp_right).with.offset(-10)
}
```

## Update the view constraints
Modify the view to the left from 20 other views
```swift
view.whc_Left(20)
// or
view.whc_Left(20, toView: otherView)
```

## Can be directly modified constraints on the Xib and Storyboard
If the view of xib leading now amended as left constraints
```swift
/// First remove the xib view of leading and then add new constraints
view.whc_RemoveAttrs(.leading)
    .whc_Left(10)
```

## Remove the constraint

Remove all constraints associated with view left
```swift
view.whc_RemoveAttrs(.left)
```
To remove multiple constraints associated with view
```swift
view.whc_RemoveAttrs(.left, .leading, .top)
// or 
view.whc_RemoveTo(linkView, attrs: .left ...)
```

## Modify the view constraint priority

Modify the view constraint for low priority right
```swift
view.whc_Right(10)
    .whc_PriorityLow()
```

## One line of code calculation cell height

No reuse way calculated cell height
```swift
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewCell.whc_CellHeightForIndexPath(indexPath, tableView: tableView)
}
```

Reuse way calculated cell height
```swift
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewCell.whc_CellHeightForIndexPath(indexPath, 
                                    tableView: tableView, 
                                    identifier: "kFirendsCircleCellIdentifier",
                                    layoutBlock: { (cell) in
        /// use model layout cell
        cell.setFriendModel(model)
    })
}
```
## Use WHC_StackView

Create WHC_StackView
```swift
let stackView = WHC_StackView()
self.view.addSubview(stackView)
```

Add constraint
```swift
stackView.whc_Left(10)
         .whc_Top(10)
         .whc_Right(10)
         .whc_HeightAuto()
```

Configuration stackView

**1.** Set the padding
```swift
stackView.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10) // 内边距
```
**2.** Set the layout direction
```swift
stackView.whc_Orientation = .Vertical                  // 自动垂直布局
```
**3.** Set the child views lateral clearance
```swift
stackView.whc_HSpace = 10                             // 子视图横向间隙
```
**4.** Set the child views vertical clearance
```swift
stackView.whc_VSpace = 10                             // 子视图垂直间隙
```
**5.** Add subview and start the layout 
```swift
for _ in 0 ... 3 {
    let view = UIView()
    stackView.addSubview(view)        
}
stackView.whc_StartLayout()
```
Prompt
==============
For more UI layout automatically, WHC_StackView components, one line of code to calculate the cell height module, please download this demo to check the specific usage

Licenses
==============
All source code is licensed under the MIT License.


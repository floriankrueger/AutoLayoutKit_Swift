# AutoLayoutKit for Swift

A descriptive way to create NSLayoutConstraints for AutoLayout in iOS 6.0+ and access / modify them on runtime. Now for Swift.

## Important

AutoLayoutKit for Swift is still being developed so all APIs are subject to change. The project should not be considered 'complete' yet (inequality relations are missing for example).

## Usage

Let me show you a few basic examples on how to use AutoLayoutKit for Swift.

```Swift
// Center a UIView 'childView' in self.view and make it 30 by 30 in size
AutoLayoutKit.layout(childView) { c in
  c.make(.CenterX, equalTo: self.view, s: .CenterX)
  c.make(.CenterY, equalTo: self.view, s: .CenterY)
  c.set(.Width, to: 30.0)
  c.set(.Height, to: 30.0)
}

// The same, but using the convenience methods
AutoLayoutKit.layout(childView) { c in
  c.centerIn(self.view)
  c.setSize(CGSize(width: 30.0, height: 30.0))
}

// Align a UIView 'container' to all edges of self.view
AutoLayoutKit.layout(container) { c in
  c.make(.Left, equalTo: self.view, s: .Left)
  c.make(.Right, equalTo: self.view, s: .Right)
  c.make(.Top, equalTo: self.view, s: .Top)
  c.make(.Bottom, equalTo: self.view, s: .Bottom)
}

// The same, but using the convenience methods
AutoLayoutKit.layout(container) { c in
  c.alignAllEdges(self.view); return
}

// Align a UIView 'container' to all edges of self.view 
// and leave a 30 point margin around the container
AutoLayoutKit.layout(container) { c in
  c.make(.Left, equalTo: self.view, s: .Left, plus: 30.0)
  c.make(.Right, equalTo: self.view, s: .Right, minus: 30.0)
  c.make(.Top, equalTo: self.view, s: .Top, plus: 30.0)
  c.make(.Bottom, equalTo: self.view, s: .Bottom, minus: 30.0)
}

// Make use of the LayoutGuides provided by UIViewController
AutoLayoutKit.layout(container) { c in
  c.make(.Left, equalTo: self.view, s: .Left)
  c.make(.Right, equalTo: self.view, s: .Right)
  c.make(.Top, equalTo: self.topLayoutGuide, s: .Baseline)
  c.make(.Bottom, equalTo: self.bottomLayoutGuide, s: .Baseline)
}

// Storing NSLayoutConstraints for later modification
// 'make' and 'set' return a tuple of type (constraint: NSLayoutConstraint?, targetItem: UIView?)
// the 'constraint' is the created NSLayoutConstraint, the 'targetItem' is the view to which
// the NSLayoutConstraint was added. It is the nearest common superview of the UIViews involved
AutoLayoutKit.layout(container) { c in
  self.leftConstaint = c.make(.Left, equalTo: self.view, s: .Left).constraint
  self.rightConstaint = c.make(.Right, equalTo: self.view, s: .Right).constraint
  self.topConstaint = c.make(.Top, equalTo: self.topLayoutGuide, s: .Baseline).constraint
  self.bottomConstaint = c.make(.Bottom, equalTo: self.bottomLayoutGuide, s: .Baseline).constraint
}

// afterwards, just modify the constraint's constant and apply the changes (this is plain AutoLayout)
UIView.animateWithDuration(0.6) { () -> Void in
  self.topConstraint?.constant = 100
  self.view.layoutIfNeeded()
}

// The convenience methods return arrays of the mentioned tuples. These will be dictionaries or tuples
// in the future as well to provide easier access to the created constraints. Until then, check the
// code for the order of the returned constraints.
```

## Hairlines

There is a utility method to create hairlines which takes the screen scale into account:

```Swift
AutoLayoutKit.layout(mySeparatorLine) { c in
  c.make(.Left, equalTo: self.view, s: .Left)
  c.make(.Right, equalTo: self.view, s: .Right)
  c.make(.Top, equalTo: self.topLayoutGuide, s: .Baseline)

  // sets the .Height to 1.0 on non-retina displays and to 0.5 on retina displays
  c.makeHorizontalHairline()
}
```

## Installation

AutoLayoutKit for Swift is available as a Cocoa Touch Framework which you can add to your project as a dependency. The best is to add AutoLayoutKit to your repository as a submodule to keep your code up to date.

Otherwise, take the files 'AutoLayoutKit/AutoLayoutKit.swift' and 'AutoLayoutKit/LayoutProxy.swift' and add them to your project.

## Author

Florian Krueger, florian.krueger@projectserver.org

## License

*AutoLayoutKit* is available under the MIT license. See the LICENSE file for more info.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/floriankrueger/autolayoutkit_swift/trend.png)](https://bitdeli.com/free "Bitdeli Badge")


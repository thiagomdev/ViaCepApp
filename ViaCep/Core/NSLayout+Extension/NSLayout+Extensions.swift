import UIKit
extension NSLayoutConstraint {
    static func didActivePin(_ constraints: [NSLayoutConstraint]) {
        for constraint in constraints {
            let firstView = constraint.firstItem as? UIView
            if firstView?.superview != nil {
                firstView?.translatesAutoresizingMaskIntoConstraints = false
            }
            
            let secondView = constraint.secondItem as? UIView
            if secondView?.superview != nil {
                secondView?.translatesAutoresizingMaskIntoConstraints = false
            }
            
            let firstGuide = constraint.firstItem as? UILayoutGuide
            if firstGuide?.owningView?.superview != nil {
                firstGuide?.owningView?.translatesAutoresizingMaskIntoConstraints = false
            }
            
            let secondGuide = constraint.secondItem as? UILayoutGuide
            if secondGuide?.owningView?.superview != nil {
                secondGuide?.owningView?.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        NSLayoutConstraint.activate(constraints)
    }
}


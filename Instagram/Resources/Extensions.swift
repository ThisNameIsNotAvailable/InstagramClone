//
//  Extensions.swift
//  Instagram
//
//  Created by Alex on 21/10/2022.
//

import UIKit

extension UIView {
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}

extension UIButton {
    var adaptiveWidth: CGFloat {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        return labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right
    }
    
    var adaptiveHeight: CGFloat {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        return labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom
    }
}

extension UIImage {
    static func createImage(color: UIColor = .random, size: CGSize = CGSize(width: 100, height: 100), text: String) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        let nameLabel = UILabel(frame: rect)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = color
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        nameLabel.text = text
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}

extension CGFloat {
    /// Returns random number.
    static var random: CGFloat {
        return CGFloat.random(in: 0...1)
    }
}

extension UIColor {
    /// Returns random color
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}

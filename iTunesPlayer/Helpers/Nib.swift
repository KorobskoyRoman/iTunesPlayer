//
//  Nib.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 26.12.2021.
//

import UIKit

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

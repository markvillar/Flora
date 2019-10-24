//
//  StackView+Extension.swift
//  Flora
//
//  Created by Mark on 24/10/2019.
//  Copyright © 2019 Mark Villar. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach{addArrangedSubview($0)}
    }
}

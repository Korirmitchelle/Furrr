//
//  StringExtension.swift
//  Furr
//
//  Created by Mitch on 24/02/2020.
//  Copyright © 2020 Mitch. All rights reserved.
//

import Foundation
extension String {
    func separate(every stride: Int = 4, with separator: Character = "_") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
}

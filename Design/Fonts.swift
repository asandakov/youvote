//
//  Fonts..swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//
import UIKit
import Foundation

struct Fonts {
             
    
    struct Text {
        
        static func textSemiboldFont(size: CGFloat) -> UIFont? {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        
        static func textMediumFont(size: CGFloat) -> UIFont? {
            return UIFont.systemFont(ofSize: size, weight: .medium)
        }
        
        static func textLightFont(size: CGFloat) -> UIFont? {
            return UIFont.systemFont(ofSize: size, weight: .light)
        }
        
        static func textRegularFont(size: CGFloat) -> UIFont? {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
                  
    }
}

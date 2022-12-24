//
//  SkintonePickerViewController.swift
//
//  EmojiPickerViewController
//  https://github.com/yosshi4486/EmojiPickerViewController
// 
//  Created by 山田良治 on 2022/12/24.
//
// ----------------------------------------------------------------------------
//
//  © 2022  yosshi4486
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  

#if os(iOS)
import UIKit

/*
 Plans for Implementing Skintone Variation & Picker
 1. Attach a UILongPressGestureRecognizer to each cell's content view.(with haptics feedback, UIFeedbackGenerator)
 2. Show a `SkintonePickerViewController` as a popover controller if the emoji's `hasVariations` is `true`.
 3. The view controller shows the related skintone variations in a UICollectionView.
 4. For the simplicity of implementation, at first, even if it is an emoji like 💏, we show the all possible variation emojis in the collection view.
 */

/**
 The view controller for picking a concrete skintone of the given person emoji.
 */
class SkintonePickerViewController: UIViewController {
    
    /**
     The emoji trying to pick a skintone variation.
     
     - Precondition:
     The `hasVariations` property must be `true`.
     */
    let emoji: Emoji
    
    /**
     Initilizes this view controller by the given emoji.
     
     - Parameter emoji: The emoji trying to pick a skintone variation.
     */
    init(emoji: Emoji) {
        precondition(emoji.hasVariations, "The emoji doesn't have any variation.")
        self.emoji = emoji
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#endif

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
     The size for a collectionview cell.
     */
    let itemSize: CGSize
    
    /**
     The collection view for showing skintone variation emojis.
     */
    var collectionView: UICollectionView!
    
    /**
     The diffable data source of the skintone variation's collection view.
     
     - The number of items is 5 when the type of emoji is person, such as 👮. (ex 👮🏻‍♀️👮🏼👮🏽👮🏾👮🏿)
     - The number of items is 25 when the type of emoji is two people, such as 💏, due to 5 x 5 combination.
     */
    var dataSource: UICollectionViewDiffableDataSource<SkintonePickerSection, Emoji>!
    
    /**
     Initilizes this view controller by the given emoji.
     
     - Parameters:
         - emoji: The emoji trying to pick a skintone variation.
         - itemSIze: The cell size of each skintone variation emoji.
     */
    init(emoji: Emoji, itemSize: CGSize = .init(width: 50, height: 50)) {
        precondition(emoji.hasVariations, "The emoji doesn't have any variation.")
        self.emoji = emoji
        self.itemSize = itemSize
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Must use init(emoji:itemSize)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDataSource()
        applyData()
    }
    
}

// MARK: - Adopting UICollectionView Delegate

extension SkintonePickerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - Call handler
        fatalError("Call Handler")
    }
    
}

// MARK: - Implementing Private Methods

extension SkintonePickerViewController {
    
    private func setupView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.itemSize = itemSize
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        view.backgroundColor = .secondarySystemFill
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
    
    private func setupDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Emoji> { cell, indexPath, item in
            
            var contentConfiguration = LabelContentConfiguration()
            contentConfiguration.text = String(item.character)
            contentConfiguration.font = UIFont.systemFont(ofSize: cell.bounds.height) // Presents the emoji as equal size as the parent cell.
            contentConfiguration.textAlighment = .center

            cell.contentConfiguration = contentConfiguration

            cell.isAccessibilityElement = true
            cell.accessibilityElements = []
            cell.accessibilityTraits = .button
            cell.accessibilityLabel = "\(item.textToSpeach)"
        }
        
        dataSource = UICollectionViewDiffableDataSource<SkintonePickerSection, Emoji>(collectionView: collectionView, cellProvider: { [unowned emoji] collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: emoji)
        })
        
    }
    
    private func applyData() {
        var snapshot: NSDiffableDataSourceSnapshot<SkintonePickerSection, Emoji> = .init()
        snapshot.appendSections([.main])
        snapshot.appendItems(emoji.orderedSkinToneEmojis, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

// MARK: - Defining Types

enum SkintonePickerSection: Int {
    case main
}

#endif

//
//  ScrollView.swift
//  SpreadsheetView
//
//  Created by Kishikawa Katsumi on 3/16/17.
//  Copyright © 2017 Kishikawa Katsumi. All rights reserved.
//

import UIKit

final public class ScrollView: UIScrollView, UIGestureRecognizerDelegate {
    var columnRecords = [CGFloat]()
    var rowRecords = [CGFloat]()

    var visibleCells = ReusableCollection<Cell>()
    var visibleVerticalGridlines = ReusableCollection<Gridline>()
    var visibleHorizontalGridlines = ReusableCollection<Gridline>()
    var visibleBorders = ReusableCollection<Border>()

    typealias TouchHandler = (_ touches: Set<UITouch>, _ event: UIEvent?) -> Void
    var touchesBegan: TouchHandler?
    var touchesEnded: TouchHandler?
    var touchesCancelled: TouchHandler?

    var layoutAttributes = LayoutAttributes(startColumn: 0, startRow: 0, numberOfColumns: 0, numberOfRows: 0, columnCount: 0, rowCount: 0, insets: CGPoint.zero)

    var hasDisplayedContent: Bool {
        return columnRecords.count > 0 || rowRecords.count > 0
    }

    func resetReusableObjects() {
        for cell in visibleCells {
            cell.removeFromSuperview()
        }
        for gridline in visibleVerticalGridlines {
            gridline.removeFromSuperlayer()
        }
        for gridline in visibleHorizontalGridlines {
            gridline.removeFromSuperlayer()
        }
        for border in visibleBorders {
            border.removeFromSuperview()
        }
        visibleCells = ReusableCollection<Cell>()
        visibleVerticalGridlines = ReusableCollection<Gridline>()
        visibleHorizontalGridlines = ReusableCollection<Gridline>()
        visibleBorders = ReusableCollection<Border>()
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer is UIPanGestureRecognizer
    }

    override public func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        return hasDisplayedContent
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard hasDisplayedContent else {
            return
        }
        touchesBegan?(touches, event)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard hasDisplayedContent else {
            return
        }
        touchesEnded?(touches, event)
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard hasDisplayedContent else {
            return
        }
        touchesCancelled?(touches, event)
    }
}
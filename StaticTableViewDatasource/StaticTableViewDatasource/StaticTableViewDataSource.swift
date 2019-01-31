//  Global Mobile
//
//  Created by Nathan Mann on 8/30/16.
//  Copyright © 2016 Pest Elimination. All rights reserved.
//

import UIKit


open class StaticTableViewDataSource: NSObject {

    public struct Cell {
        let row: UITableViewCell
        let didSelect: (() -> ())?
        let popUpCopyMenuItem: String?
    }


    public struct Section {

        let title: String?
        let footer: String?
        var footerView: UIView?
        
        
        fileprivate var cells: [Cell]

        fileprivate init(title: String?, footer: String?, cells: [Cell]) {
            self.title = title
            self.footer = footer
            self.cells = cells
        }
        
        
        public mutating func addCell(_ configure: () -> UITableViewCell, popUpCopyMenuItem: String? = nil, didSelect: (() -> ())? = nil) {
            let cell = Cell(row: configure(), didSelect: didSelect, popUpCopyMenuItem: popUpCopyMenuItem)
            self.cells.append(cell)
        }
        
        public mutating func addFooterView(_ view: UIView) {
            self.footerView = view
        }
    }


    public var sections: [Section] = []


    public func addSection(_ title: String?, footer: String? = nil,  configure: (inout Section) -> Void) {
        var section = Section(title: title, footer: footer, cells: [])
        configure(&section)
        sections.append(section)
    }

}




extension StaticTableViewDataSource: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }


    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }


    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }

    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sections[section].footerView
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }


    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        return section.cells[indexPath.row].row
    }
    
}



extension StaticTableViewDataSource: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        section.cells[indexPath.row].didSelect?()
    }


    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }


    public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        let section = sections[indexPath.section]
        return section.cells[indexPath.row].popUpCopyMenuItem != nil
    }


    public func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy(_:))
    }


    public func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        let section = sections[indexPath.section]
        let cell = section.cells[indexPath.row]

        UIPasteboard.general.string = cell.popUpCopyMenuItem
    }
}



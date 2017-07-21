//  Global Mobile
//
//  Created by Nathan Mann on 8/30/16.
//  Copyright © 2016 Pest Elimination. All rights reserved.
//

import Foundation


final class StaticTableViewDataSource: NSObject {

    fileprivate struct Cell {
        let row: UITableViewCell
        let didSelect: (() -> ())?
    }


    struct Section {

        let title: String?
        fileprivate var cells: [Cell]

        mutating func addCell(_ configure: () -> UITableViewCell, didSelect: (() -> ())? = nil) {
            let cell = Cell(row: configure(), didSelect: didSelect)
            self.cells.append(cell)
        }
    }


    var sections: [Section] = []


    func addSection(_ title: String?, configure: (inout Section) -> Void) {
        var section = Section(title: title, cells: [])
        configure(&section)
        sections.append(section)
    }

}




extension StaticTableViewDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }


    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        return section.cells[indexPath.row].row
    }
    
}



extension StaticTableViewDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        section.cells[indexPath.row].didSelect?()
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}



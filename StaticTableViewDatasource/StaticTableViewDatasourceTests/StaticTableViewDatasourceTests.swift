//
//  StaticTableViewDatasourceTests.swift
//  StaticTableViewDatasourceTests
//
//  Created by Nathan Mann on 7/21/17.
//  Copyright © 2017 Nate Mann. All rights reserved.
//

import XCTest
import StaticTableViewDatasource


class StaticTableViewDatasourceTests: XCTestCase {
    

    let tableView = UITableView()

    var datasource: StaticTableViewDataSource!
    var didSelectCell: Bool!

    override func setUp() {
        super.setUp()

        //create the datasource
        datasource = StaticTableViewDataSource()
        didSelectCell = false
        //first add a section with no title and one cell
        datasource.addSection(nil) { section in
            section.addCell({
                let cell = UITableViewCell()
                cell.textLabel?.text = "This is the First Cell"
                return cell
            })
        }

        datasource.addSection("2nd Section Title") { section in
            section.addCell({
                let cell = UITableViewCell()
                cell.textLabel?.text = "This cell has no action associated with it"
                return cell
            })
            section.addCell({
                let cell = UITableViewCell()
                cell.textLabel?.text = "This cell has an action associated with it"
                return cell
            }, didSelect: { 
                self.didSelectCell = true
            })
        }

        tableView.dataSource = datasource
        tableView.delegate = datasource
    }


    //MARK: 1st Section Tests

    func test_first_section_has_no_title() {
        let title = datasource.tableView(tableView, titleForHeaderInSection: 0)
        XCTAssertNil(title)
    }


    func test_first_section_number_of_cells() {
        let cellCount = datasource.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(cellCount, 1)
    }


    func test_first_section_cell() {
        let cell = datasource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, "This is the First Cell")
    }


    //MARK: 2nd Section Tests

    func test_second_section_title() {
        let title = datasource.tableView(tableView, titleForHeaderInSection: 1)
        XCTAssertEqual(title, "2nd Section Title")
    }


    func test_second_section_number_of_cells() {
        let cellCount = datasource.tableView(tableView, numberOfRowsInSection: 1)
        XCTAssertEqual(cellCount, 2)
    }


    func test_cell_didSelect() {
        datasource.tableView(tableView, didSelectRowAt: IndexPath(row: 1, section: 1))
        XCTAssertTrue(didSelectCell)
    }
    
}

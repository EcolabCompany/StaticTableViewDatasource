import XCTest
@testable import StaticTableViewDatasource

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

        //Second, add a section with title and 2 cells
        datasource.addSection("2nd Section Title", footer: "2nd Section Footer") { section in
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

        //Third, add a section to test long press copy functionality
        datasource.addSection("3rd Section Title") { section in
            section.addCell({
                let cell = UITableViewCell()
                cell.textLabel?.text = "This cell has a long press copy functionality associated with it"
                return cell
            }, popUpCopyMenuItem: "cell copied")

        }

        tableView.dataSource = datasource
        tableView.delegate = datasource
    }


    func test_number_of_sections() {
        let sectionCount = datasource.numberOfSections(in: tableView)
        XCTAssertEqual(sectionCount, 3)
    }


    //MARK: 1st Section Tests

    func test_first_section_has_no_title() {
        let title = datasource.tableView(tableView, titleForHeaderInSection: 0)
        XCTAssertNil(title)
    }


    func test_first_section_has_no_footer() {
        let footer = datasource.tableView(tableView, titleForHeaderInSection: 0)
        XCTAssertNil(footer)
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


    func test_second_section_footer() {
        let footer = datasource.tableView(tableView, titleForFooterInSection: 1)
        XCTAssertEqual(footer, "2nd Section Footer")
    }


    func test_second_section_number_of_cells() {
        let cellCount = datasource.tableView(tableView, numberOfRowsInSection: 1)
        XCTAssertEqual(cellCount, 2)
    }


    func test_cell_didSelect() {
        datasource.tableView(tableView, didSelectRowAt: IndexPath(row: 1, section: 1))
        XCTAssertTrue(didSelectCell)
    }


    //MARK: 3rd Section Tests
    func test_shouldShowMenuForRowAt_indexPath_returns_true() {
        XCTAssertTrue(datasource.tableView(tableView, shouldShowMenuForRowAt: IndexPath(row: 0, section: 2)))
    }


    func test_shouldShowMenuForRowAt_indexPath_returns_false() {
        XCTAssertFalse(datasource.tableView(tableView, shouldShowMenuForRowAt: IndexPath(row: 0, section: 1)))
    }


    func test_text_copied_to_pastBoard() {
        datasource.tableView(tableView, performAction: #selector(UIResponderStandardEditActions.copy(_:)), forRowAt: IndexPath(row: 0, section: 2), withSender: nil)
        XCTAssertEqual(UIPasteboard.general.string, "cell copied")
    }
}

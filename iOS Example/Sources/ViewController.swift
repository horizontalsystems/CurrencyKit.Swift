import UIKit
import ComponentKit
import SnapKit
import SectionsTableView
import CurrencyKit
import StorageKit

class ViewController: UIViewController {
    private let tableView = SectionsTableView(style: .grouped)
    private let currencyKit: CurrencyKit.Kit

    init() {
        currencyKit = CurrencyKit.Kit(localStorage: StorageKit.LocalStorage.default)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Currency"
        navigationItem.largeTitleDisplayMode = .never

        tableView.sectionDataSource = self
        tableView.separatorColor = .clear
        tableView.registerCell(forClass: BaseThemeCell.self)

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.buildSections()
    }

}

extension ViewController: SectionsDataSource {

    private func row(index: Int, currency: Currency) -> RowProtocol {
        let isLast = currencyKit.currencies.count - 1 == index
        return CellBuilderNew.row(
                rootElement: .hStack([
                    .image32 { component in
                        component.imageView.image = Kit.currencyIcon(code: currency.code)
                    },
                    .text { component in
                        component.text = "\(currency.code) - \(currency.symbol)"
                    }
                ]),
                tableView: tableView,
                id: "some",
                height: 60,
                bind: { cell in
                    cell.set(backgroundStyle: .lawrence, isFirst: index == 0, isLast: isLast)
                }
        )
    }

    func buildSections() -> [SectionProtocol] {
        [Section(id: "section", rows: currencyKit.currencies.enumerated().map(row))]
    }

}

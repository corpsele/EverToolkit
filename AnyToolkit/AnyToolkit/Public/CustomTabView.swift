//
//  CustomTabView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/1/29.
//

import UIKit
import SwiftUI

struct CustomTableItem: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
}

private extension UITableViewCell {
    static let reuseIdentifier = "UITableViewCell"
}

final class CustomTableViewCoodinator: NSObject, UITableViewDelegate, UITableViewDataSource{
    var items: [CustomTableItem] = []
    
    init(items: [CustomTableItem]) {
        self.items = items
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        
        var item = items[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = item.title
        config.secondaryText = item.subTitle
        cell.contentConfiguration = config
        
        return cell
    }
    
    
}

final class CustomTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

/// 自定义tableView
struct CustomTableView: UIViewRepresentable {
    var items: [CustomTableItem]
    
    func makeCoordinator() -> CustomTableViewCoodinator {
        CustomTableViewCoodinator(items: items)
    }
    
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: UITableViewCell.reuseIdentifier
        )
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.backgroundColor = .clear // 方便你在 SwiftUI 外面自定义背景
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
        context.coordinator.items = items
//        context.coordinator.onSelect = onSelect
//        uiView.setEditing(isEditing, animated: true)
        uiView.reloadData()
    }
    
}

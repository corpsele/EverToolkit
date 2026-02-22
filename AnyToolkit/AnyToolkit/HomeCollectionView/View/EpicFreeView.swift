//
//  EpicFreeView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/22.
//

import SwiftUI

struct EpicFreeView: View {
    @StateObject private var viewModel = EpicFreeVM()
    // 点击回调给外部使用
    var onItemTap: ((EpicFreeModel) -> Void)?
    
    let rows = [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12),
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
//            LazyVGrid(
//                columns: [
//                    GridItem(.flexible(), spacing: 12),
//                    GridItem(.flexible(), spacing: 12)
//                ],
//                spacing: 12
//            )
            LazyHGrid(
                rows: rows,
                spacing: 12
            )
            {
                if let models = viewModel.items?.data {
                    ForEach(models) { item in
                        EpicFreeCellView(item: item)
                            .onTapGesture {
                                // 点击事件交给 ViewModel，再由外部回调处理
                                viewModel.handleItemTap(item)
                                onItemTap?(item)
                            }
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .onAppear {
            viewModel.loadData()
        }
        .alert(item: $viewModel.epicErrorMessage) { error in
            Alert(
                title: Text("提示"),
                message: Text(error.errorMessage),
                dismissButton: .default(Text("确定"))
            )
        }
    }
}

struct EpicFreeCellView: View {
    let item: EpicFreeModel
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.title)
                .font(.headline)
                .foregroundColor(.primary)
            // 示例：用 colorHex 转成 Color（简单写法）
//            Color(hex: item.colorHex)
//                .frame(height: 100)
//                .cornerRadius(8)
            Text(item.original_price_desc)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

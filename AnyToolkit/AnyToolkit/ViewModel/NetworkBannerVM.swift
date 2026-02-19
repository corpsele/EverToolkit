//
//  NetworkBannerVM.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/17.
//

import Combine
import SwiftUI

class NetworkBannerVM: ObservableObject {

    // MARK: - 输出给 View 的状态

    /// 当前显示的页面索引
    @Published var currentPage: Int = 0

    /// 总页数
    let totalPages: Int
    
    /// 点击某张图片的回调，参数是索引
    var onTap: ((Int) -> Void)?

    // MARK: - 内部状态

    private var autoScrollCancellable: AnyCancellable?
    private let autoScrollInterval: TimeInterval

    // MARK: - Init

    init(
        totalPages: Int,
        autoScrollInterval: TimeInterval = 3.0,
        onTap: ((Int) -> Void)? = nil
    ) {
        self.totalPages = totalPages
        self.autoScrollInterval = autoScrollInterval
        self.onTap = onTap
    }

    deinit {
        stopAutoScroll()
    }

    // MARK: - 自动滚动控制

    /// 开始自动滚动
    func startAutoScroll() {
        // 防止重复创建多个 Timer
        stopAutoScroll()

        autoScrollCancellable =
            Timer
            .publish(
                every: autoScrollInterval,
                on: .main,
                in: .common
            )
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.goToNextPage()
            }
    }

    /// 停止自动滚动
    func stopAutoScroll() {
        autoScrollCancellable?
            .cancel()
        autoScrollCancellable = nil
    }

    // MARK: - 页码切换

    /// 下一页（循环）
    func goToNextPage() {
        let nextPage = (currentPage + 1) % totalPages
        setCurrentPage(
            nextPage,
            animated: true
        )
    }

    /// 上一页（循环）
    func goToPrevPage() {
        let prevPage = (currentPage - 1 + totalPages) % totalPages
        setCurrentPage(
            prevPage,
            animated: true
        )
    }

    /// 直接跳到指定页
    func setCurrentPage(
        _ page: Int,
        animated: Bool
    ) {
        let target = max(
            0,
            min(
                page,
                totalPages - 1
            )
        )
        if animated {
            withAnimation {
                currentPage = target
            }
        } else {
            currentPage = target
        }
    }
    
    // MARK: - 点击事件处理

    /// View 里调用，把点击事件透传给外部
    func handleTap(index: Int) {
        onTap?(index)
    }
}

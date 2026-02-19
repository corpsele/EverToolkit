//
//  NetworkBannerView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/17.
//

import SwiftUI
import Kingfisher
import KingfisherWebP

struct NetworkBannerView: View {
    
    @StateObject private var vm: NetworkBannerVM
    
    private let imageUrls: [String]
    
    init(
        imageUrls: [String],
        autoScrollInterval: TimeInterval = 3.0,
        onTap: ((Int) -> Void)? = nil
    ) {
        self.imageUrls = imageUrls
        
        // 这里传入图片数量，自动滚动间隔可自行调整
        _vm = StateObject(
            wrappedValue: NetworkBannerVM(
                totalPages: imageUrls.count,
                autoScrollInterval: autoScrollInterval,
                onTap: onTap
            )
        )
    }
    
    
    var body: some View {
        
        TabView(
            selection: $vm.currentPage
        ) {
            ForEach(
                0..<imageUrls.count,
                id: \.self
            ) { index in
                let urlComp = URLComponents(
                    string: imageUrls[index]
                )
                let url = urlComp?.url
                // 使用 KFImage 加载网络图片
                KFImage(
                    url
                )
                .onSuccess { result in
                    print(
                        "result = \(result)"
                    )
                }
                .onFailure { error in
                    print(
                        "error = \(error)"
                    )
                }
                .placeholder {
                    ProgressView() // 加载中显示菊花
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity
                        )
                        .background(
                            Color.gray.opacity(
                                0.1
                            )
                        )
                }
                .resizable()
//                .scaledToFill()
                .scaledToFit()
//                .frame(
//                    height: 200
//                )
                .clipped()
                .tag(
                    index
                )
                .onTapGesture {
                    // 点击事件交给 ViewModel 处理
                    vm.handleTap(index: index)
                }
            }
        }
        .tabViewStyle(
            // 分页样式有小圆点
//            PageTabViewStyle()
            .page(indexDisplayMode: .automatic)
        )
//        .frame(
//            height: 200
//        )
//        .onReceive(
//            vm.timer
//        ) { _ in
//            // 自动播放逻辑
//            withAnimation {
//                
//                
//            }
//        }
        
        .onAppear {
            // 配置 UIPageControl 的颜色（全局）
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.red
            
            KingfisherManager.shared.defaultOptions += [
                .processor(
                    WebPProcessor.default
                ),
                .cacheSerializer(
                    WebPSerializer.default
                )
            ]
//            KingfisherManager.shared.defaultOptions += [
//                .processor(
//                    DownsamplingImageProcessor.init(
//                        size: CGSize(
//                            width: 300,
//                            height: 200
//                        )
//                    )
//                ),
//                .cacheSerializer(
//                    DefaultCacheSerializer.default
//                )
//            ]
            
            vm
                .startAutoScroll()
        }
        .onDisappear {
            vm
                .stopAutoScroll()
        }
    }
}

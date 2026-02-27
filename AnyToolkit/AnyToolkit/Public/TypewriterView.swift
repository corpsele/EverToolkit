//
//  TypewriterView.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/27.
//

import SwiftUI
import Combine

// MARK: - 1. 打字机文本组件
struct TypewriterText: View {
    // 要显示的完整文本
    let fullText: String
    // 打字速度（秒）
    let speed: Double
    
    // 当前显示的文本
    @State private var displayedText: String = ""
    // 光标闪烁状态
    @State private var cursorOpacity: Double = 1.0
    // 计时器引用
    @State private var timer: Timer?
    
    init(_ text: String, speed: Double = 0.05) {
        self.fullText = text
        self.speed = speed
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            // 显示的文本
            Text(displayedText)
                .font(.system(size: 24, weight: .medium, design: .monospaced))
                .foregroundColor(.white)
            
            // 闪烁的光标
            Text("|")
                .font(.system(size: 24, weight: .medium, design: .monospaced))
                .foregroundColor(.white)
                .opacity(cursorOpacity)
                // 只要在打字，光标就持续闪烁；打完了常亮或根据需求隐藏
                .onAppear {
                    startCursorBlink()
                }
        }
        .onAppear {
            startTyping()
        }
        .onDisappear {
            // 页面消失时清理计时器，防止内存泄漏
            timer?.invalidate()
            timer = nil
        }
    }
    
    // MARK: - 打字逻辑
    func startTyping() {
        // 如果是空文本，直接返回
        guard !fullText.isEmpty else { return }
        
        displayedText = ""
        var currentIndex = 0
        
        // 创建计时器
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { t in
            // 判断是否打完
            if currentIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
                displayedText.append(fullText[index])
                currentIndex += 1
            } else {
                // 打完了，停止计时器
                t.invalidate()
                timer = nil
                // 可选：打完后光标停止闪烁或消失
                cursorOpacity = 1.0
            }
        }
    }
    
    // MARK: - 光标闪烁逻辑
    func startCursorBlink() {
        // 使用另一个独立的计时器控制闪烁
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { t in
            // 如果主计时器已经停止（打字结束），可以选择停止闪烁
            // 这里演示持续闪烁，直到视图消失
            withAnimation(.easeInOut(duration: 0.5)) {
                cursorOpacity = (cursorOpacity == 1.0) ? 0.0 : 1.0
            }
        }
    }
}

// MARK: - 2. 演示界面
struct TypewriterView: View {
    @State private var inputText = "Hello SwiftUI! This is a typewriter effect."
    @State private var trigger = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // 显示打字机效果的区域
                VStack(alignment: .leading) {
                    Text("Terminal Output:")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    // 放入组件
                    TypewriterText(inputText, speed: 0.1)
                        .padding()
                        .background(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.green, lineWidth: 1)
                        )
                }
                .padding()
                
                // 控制区域
                VStack(spacing: 15) {
                    TextField("输入内容", text: $inputText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        // 通过改变触发器或重置文本来重新播放
                        // 这里简单通过改变字符串触发（实际可能需要重置状态）
                        // 由于 TypewriterText 内部是在 onAppear 启动，
                        // 我们需要让它重新加载，可以使用 .id() 修饰符
                        trigger.toggle()
                    }) {
                        Text("重新播放")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
        // 关键：使用 .id() 强制视图重建，从而重新触发 onAppear
        .id(trigger)
    }
}

// MARK: - 3. Preview
struct TypewriterView_Previews: PreviewProvider {
    static var previews: some View {
        TypewriterView()
    }
}

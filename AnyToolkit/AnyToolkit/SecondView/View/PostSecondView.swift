//
//  Untitled.swift
//  AnyToolkit
//
//  Created by corpsele_n on 2026/2/10.
//  Post二级

import SwiftUI
import CLSDK_Framework

public struct PostSecondView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var vm = PostSecondVM()
    
    @State private var txtStr: String
    
    @EnvironmentObject private var settings: Settings
    
    @State private var naviHidden = false
    
    private let sm4 = Sm4Impl()
    
    
    public init() {
//        _ = sm4.setKey(key: "571aaac457fbec8e", iv: "571aaac457fbec8e", hex: false)
        _ = sm4.setKey(key: "7df549830d7f9cbfc27148a76ff153ab", iv: "7df549830d7f9cbfc27148a76ff153ab", hex: true)
//        let key = "0123456789abcdef"  // 16字节的UTF-8字符串
//        let iv = "fedcba9876543210"   // 16字节的UTF-8字符串
        let key = "0123456789abcdeffedcba9876543210"
        let iv  = "00000000000000000000000000000000"
        let plainText = "hello AnyToolkit"
        var hexResult = ""
        // 1. 加密为 Hex 格式
//        do {
//            hexResult = try SM4Cryptor.encryptToHex(plainText: plainText, key: key, iv: iv, mode: .CBC)
//            print("Hex 加密结果: \(hexResult)")
//        }catch{
//            
//        }
        if let cipherHex = SM4Utils.encrypt(plainText: plainText, keyHex: key, ivHex: iv, mode: .CBC, outputType: .hex) {
            hexResult = cipherHex
            print("CBC Hex 密文: \(cipherHex)")
        }
        
        self._txtStr = State(initialValue: hexResult)
    }
    
    @available(iOS 15.0, *)
    public struct TextEditorView: View {
        @State private var attrStr: AttributedString
        @State private var txtStr: String
        
        public init(txtStr: String) {
            self.txtStr = txtStr
            self.attrStr = AttributedString(txtStr)
        }
        
        public init(attrStr: AttributedString, txtStr: String) {
            self.attrStr = attrStr
            self.txtStr = txtStr
        }
        
        public var body: some View {
            if #available(iOS 26.0, *) {
                TextEditor(text: $attrStr)
            } else {
                TextEditor(text: $txtStr)
            }
            
        }
    }
    
    public var body: some View {
//        NavigationView {
            BaseViewContainer(viewModel: vm, title: "二级页面") {
                VStack(alignment: .center, spacing: 4) {
                    buildTextEdit()
                        .frame(minHeight: 50)
                        
                    
                    Spacer()
                    
                    buildTextEdit()
                        .frame(minHeight: 50)
                        
                    
                    Spacer()
                    
                    List {
                        
                    }
                    
                }
                
            }
            // 自定义导航后需要适配偏移顶部区域，否则覆盖页面组件
            .padding(.top)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .navigationBarHidden(true)
            .customNavBar(
                title: "二级页面",
                backgroundColor: .blue,
                foregroundColor: .white,
                leftAction: {
                    print("left button click")
                },
                rightAction: {
                    print("right button click")
                },
                
            )
            
        }
    
    
    @ViewBuilder
    private func buildTextEdit() -> some View {
        if #available(iOS 15.0, *) {
            PostSecondView.TextEditorView(txtStr: txtStr)
        } else {
            TextEditor(text: $txtStr)
        }
    }
//    }
}

#Preview {
    PostSecondView()
}

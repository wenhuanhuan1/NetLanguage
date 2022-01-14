//
//  WHHTheme+deinit.swift
//  ThemeTest
//
//  Created by whh on 2022/1/11.
// 释放主题切换

import Foundation

class WHLanguageDeinitBlockExecutor: NSObject {

    var deinitBlock:(() -> Void)?

    /// 构造方法
    ///
    /// - Parameter deinitBlock: 接收更换主题模式的通知block
    /// - Returns: <#return value description#>
    static func executorWithDeinitBlock(_ deinitBlock:(() -> Void)?) -> WHLanguageDeinitBlockExecutor {

        let deinitBlockExecutor: WHLanguageDeinitBlockExecutor = WHLanguageDeinitBlockExecutor()
        deinitBlockExecutor.deinitBlock = deinitBlock
        return deinitBlockExecutor

    }

    /// 执行析构方法，释放注册的通知
    deinit {
        if deinitBlock != nil {
            deinitBlock!()
            deinitBlock = nil
        }
    }

}

extension NSObject {

    /// 记录需要释放的通知主体
    func addLanguageDeinitBlock(_ deinitBlock:(() -> Void)?) -> Any? {

        guard let deinitBlock = deinitBlock else { return nil }

        let deinitBlockExecutor: WHLanguageDeinitBlockExecutor = WHLanguageDeinitBlockExecutor.executorWithDeinitBlock(deinitBlock)

        return deinitBlockExecutor
    }

}

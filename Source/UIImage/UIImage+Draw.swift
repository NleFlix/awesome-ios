//
//  UIImage+Draw.swift
//  ElegantUI
//
//  Created by John on 2019/3/20.
//  Copyright © 2019 ElegantUI. All rights reserved.
//

import UIKit

public extension UIImage {
    /// 对图片染色
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - blendMode: 渲染默认
    /// - Returns: 新的图片
    func tint(_ color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }

    /// 传入 logo 图片，logo 位置 logo 大小 就可以得到一张生成好的图片 
    ///
    /// - Parameters:
    ///   - logo: 图片
    ///   - logoOrigin: 位置
    ///   - logoSize: 大小
    /// - Returns: 生成好的图片 
    func composeImageWithLogo(logo: UIImage,
                              logoOrigin: CGPoint) -> UIImage {
        //以bgImage的图大小为底图
        let imageRef = self.cgImage
        let width: CGFloat = CGFloat((imageRef?.width)!)
        let height: CGFloat = CGFloat((imageRef?.height)!)
        //以1.png的图大小为画布创建上下文
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        //先把1.png 画到上下文中
        let logoWidth = logo.size.width * scale
        let logoHeight = logo.size.height * scale
        logo.draw(in: CGRect(x: logoOrigin.x * scale - logoWidth/2,
                             y: logoOrigin.y * scale - logoHeight/2,
                             width: logoWidth,
                             height: logoHeight))
        //再把小图放在上下文中
        let resultImg: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        //从当前上下文中获得最终图片
        UIGraphicsEndImageContext()
        return resultImg!
    }

    /// 生成带文字的图片，方便用于 NSTextAttachment
    /// - Parameters:
    ///   - attributedString: 文字
    ///   - size: 图片尺寸
    ///   - backColor: 背景颜色
    ///   - radius: 圆角
    ///   - bgImage: 背景图片
    static func titleToImage(attributedString: NSAttributedString,
                             size: CGSize,
                             backColor: UIColor? = .clear,
                             radius: CGFloat? = nil,
                             bgImage: UIImage? = nil) -> UIImage {
        let scale = UIScreen.main.scale
        let label = UILabel(frame: CGRect(origin: .zero, size: size))
        label.backgroundColor = backColor
        label.numberOfLines = 0
        label.attributedText = attributedString
        label.clipsToBounds = true
        if let radius = radius {
            label.layer.cornerRadius = radius
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        if let bgImage = bgImage {
            bgImage.draw(in: CGRect(origin: CGPoint.zero, size: bgImage.size))
            label.layer.render(in: UIGraphicsGetCurrentContext()!)
        }

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

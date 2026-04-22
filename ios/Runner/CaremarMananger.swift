//
//  CaremarMananger.swift
//  Runner
//
//  Created by hejinhui on 2026/4/22.
//

import Foundation
import Flutter

class CaremarMananger:NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    static let shared = CaremarMananger()
    private var flutterResult: FlutterResult?

    static func setupCarema(binaryMessenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(
          name: "com.baby/native",
          binaryMessenger: binaryMessenger
        )

        channel.setMethodCallHandler { call, result in
          switch call.method {
          case "opnCarama":
              shared.flutterResult = result
              shared.openCamear()
          default:
            result(FlutterMethodNotImplemented)
          }
        }
    }
    
    private func openCamear() {
        DispatchQueue.main.async {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            if let root = UIApplication.shared.windows.first?.rootViewController {
                root.present(picker, animated: true)
           }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {

               print("选图成功")

               // 👉 示例：返回成功信息
               flutterResult?("success from ios native")

               // 👉 如果你要返回图片（进阶）
               // let data = image.jpegData(compressionQuality: 0.8)
               // flutterResult?(data?.base64EncodedString())
           }

           flutterResult = nil  // ⭐ 必须释放
           picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        flutterResult?("cancel")
        picker.dismiss(animated: true)
    }
}

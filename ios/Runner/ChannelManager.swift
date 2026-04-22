//
//  ChannelManager.swift
//  Runner
//
//  Created by hejinhui on 2026/4/22.
//
import Flutter
import Foundation
class ChannelManager {
    static func setup(messager: FlutterBinaryMessenger) {
        CaremarMananger.setupCarema(binaryMessenger: messager)
    }
}

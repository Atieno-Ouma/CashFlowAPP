//
//  FilePickeri.swift
//  iosApp (iOS)
//
//  Created by Marco Gomiero on 18/10/2020.
//

import Foundation
import SwiftUI
import MobileCoreServices
import UniformTypeIdentifiers

struct FilePickerController: UIViewControllerRepresentable {
    var callback: (URL) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIViewController(
        _ uiViewController: UIDocumentPickerViewController,
        context: UIViewControllerRepresentableContext<FilePickerController>
    ) {
        // Update the controller
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        print("Making the picker")

        let supportedTypes: [UTType] = [UTType.item]
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)

        controller.delegate = context.coordinator
        print("Setup the delegate \(context.coordinator)")

        return controller
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: FilePickerController

        init(_ pickerController: FilePickerController) {
            self.parent = pickerController
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            self.parent.callback(urls[0])
        }

        func documentPickerWasCancelled() {
            print("Document picker was thrown away :(")
        }

        deinit {
            print("Coordinator going away")
        }
    }
}

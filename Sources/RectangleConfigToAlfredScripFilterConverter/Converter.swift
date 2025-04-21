import Foundation
import MASShortcut

struct RectangleConfig: Codable {
    struct Shortcut: Codable {
        let keyCode: Int
        let modifierFlags: Int
    }

    let shortcuts: [String: Shortcut]
    let version: String
}

struct AlfredScript: Codable {
    struct Item: Codable {
        let uid: String
        let title: String
        let subtitle: String
        let arg: String
        let icon: Icon
    }

    struct Icon: Codable {
        let path: String
    }

    var items: [Item]
}

extension String {
    func deCamelCase() -> String {
        var result = ""

        for scalar in self.unicodeScalars {
            if scalar.properties.isUppercase {
                result += " " + String(scalar).lowercased()
            } else {
                result += String(scalar)
            }
        }

        let trimmedResult = result.trimmingCharacters(in: .whitespacesAndNewlines)
        let capitalizedResult = trimmedResult.capitalized

        return capitalizedResult
    }
}

func modifierFlagsString(_ shortcut: RectangleConfig.Shortcut) -> String {
    let modifierFlags = NSEvent.ModifierFlags(rawValue: UInt(shortcut.modifierFlags))
    return MASShortcut(keyCode: 0, modifierFlags: modifierFlags).modifierFlagsString
}

func keyCodeString(_ shortcut: RectangleConfig.Shortcut) -> String {
    let modifierFlags = NSEvent.ModifierFlags(rawValue: UInt(shortcut.modifierFlags))
    return MASShortcut(keyCode: shortcut.keyCode, modifierFlags: modifierFlags).keyCodeString ?? ""
}

func readRectangleConfig(from filePath: String) throws -> RectangleConfig {
    let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
    let decoder = JSONDecoder()
    return try decoder.decode(RectangleConfig.self, from: data)
}

func createAlfredScriptItem(from key: String, shortcut: RectangleConfig.Shortcut) -> AlfredScript.Item {
    let rectangleActionName = key.deCamelCase().lowercased().replacingOccurrences(of: " ", with: "-")
    return AlfredScript.Item(
            uid: ".\(key)",
            title: key.deCamelCase(),
            subtitle: modifierFlagsString(shortcut) + keyCodeString(shortcut),
            arg: "rectangle://execute-action?name=\(rectangleActionName)",
            icon: AlfredScript.Icon(path: "WindowPositions/\(key)Template.imageset/\(key)Template.png")
    )
}

func convertRectangleConfig() {
    do {
        let rectangleConfig = try readRectangleConfig(from: "RectangleConfig.json")
        var alfredScriptFilter = AlfredScript(items: [])

        for (key, shortcut) in rectangleConfig.shortcuts {
            let item = createAlfredScriptItem(from: key, shortcut: shortcut)
            alfredScriptFilter.items.append(item)
        }

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encodedFilter = try encoder.encode(alfredScriptFilter)

        if let jsonString = String(data: encodedFilter, encoding: .utf8) {
            print(jsonString)
        }
    } catch {
        print("Error: \(error)")
    }
}
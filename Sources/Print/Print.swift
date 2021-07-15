//
//  Print.swift
//
//
//  Created by DeShawn Jackson on 11/18/19.
//

import Foundation

// MARK: -

public enum PrintType: Equatable { //String {
    case standard, error, warning, fatal, title(String?)
    
    public var value: String {
        
        let value: String = {
            switch self {
            case .standard: return "standard"
            case .error: return "error"
            case .warning: return "warning"
            case .fatal: return "fatal"
            case .title(let x): return x ?? ""
            }
        }()
        
        return value
    }
    
    public static func ==(lhs: PrintType, rhs: PrintType) -> Bool {
        
        switch (lhs, rhs) {
        case (.standard, .standard): return true
        case (.error, .error): return true
        case (.warning, .warning): return true
        case (.fatal, .fatal): return true
        case (.title(_), .title(_)): return true
        default: return false
        }
    }
}

// MARK: -

extension NSObject: Print { }
extension String: Print { }
extension Array: Print { }

// MARK: -

public protocol Print { }

extension Print {
    
    // MARK: -
    
    public func print(type printType: PrintType = .standard, _ items: Any?..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, function:  Any = #function) {

        var printType = printType
        
        if printType == .standard && items.count == 1 && items.first is Error {
            printType = .error
        }
        
        type(of: self).print(type: printType, items: items, separator, terminator, file, line, function)
    }
    
    public static func print(type printType: PrintType = .standard, _ items: Any?..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, function:  Any = #function) {
        
        print(type: printType, items: items, separator, terminator, file, line, function)
    }
    
//    // MARK: -
//
//    public func print(error: Error, title: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, function:  Any = #function) {
//
//        type(of: self).print(type: .error, items: [error], separator, terminator, file, line, function)
//    }

    // MARK: -
    
    private static func print(type printType: PrintType, items: [Any?], _ separator: String = " ", _ terminator: String = "\n", _ file: String = #file, _ line: Int = #line, _ function:  Any = #function) {
        
        // Format Date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        let now = formatter.string(from: Date())
        //let now = Date()
        //let date = now.format(dateStyle: .short, timeStyle: .none)
        //let time = now.format(dateStyle: .none, timeStyle: .medium)
        
        // Get file name
        
        let fileURL = URL(fileURLWithPath: file)
        let bundle: String = {
            if let bundle = Bundle(url: fileURL.deletingLastPathComponent())?.bundleURL.lastPathComponent {
                return bundle + "."
            } else { return "" }
        }()
        let file = fileURL.lastPathComponent
        
        // Create separators
        
        let before: String = {
            
            let value = "\n************************************************************** \(printType.value.uppercased()) **************************************************************"
            
            switch printType {
            case .standard: return ""
            // case .title(let string): return string == nil ? "" : value
            default: return value
            }
            
        }()
        
        let after: String = {
            
            let value = "\n***********************************************************************************************************************************"
            
            switch printType {
            case .standard: return ""
            // case .title(let string): return string == nil ? value : ""
            default: return value
            }
            
        }()
        
        // Unwrap nil values
        
        let items: [Any] = items.map({ $0 == nil ? $0 as Any : $0! })
        
        // Print to console
        
        Swift.print("\(before)\n[" + [now, "\(bundle)\(file)", "\(self).\(function)", line].joined(" ") + "] ", items.joined(separator) + after, separator: "", terminator: terminator)
        //if type == .fatal { fatalError() }
    }
}

extension Array {
        
    public func joined(_ separator: String) -> String {
        
        var string = ""
        
        self.enumerated().forEach({ (i, element) in
            if i > 0 { string += separator }
            string += String(describing: element)
            
        })
        
        return string
    }
}

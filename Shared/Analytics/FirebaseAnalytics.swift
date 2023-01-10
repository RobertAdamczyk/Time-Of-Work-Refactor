//
//  FirebaseAnalytics.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.01.23.
//

import Foundation
import SwiftUI
import FirebaseAnalytics
import FirebaseCore

struct Analytics {
    @AppStorage(Storable.firebaseAnalytics.key) static var firebaseAnalytics: Bool = false

    public static func activateFirebase() {
        firebaseAnalytics = true
        FirebaseApp.app()?.isDataCollectionDefaultEnabled = true
        FirebaseAnalytics.Analytics.setAnalyticsCollectionEnabled(true)

    }

    public static func deactivateFirebase() {
        firebaseAnalytics = false
        FirebaseApp.app()?.isDataCollectionDefaultEnabled = false
        FirebaseAnalytics.Analytics.setAnalyticsCollectionEnabled(false)
    }

    /// Logs a custom event with the specified name and parameter dictionary.
    public static func logFirebaseEvent(_ name: String, parameters: [String: Any] = [:]) {
        guard firebaseAnalytics else { return }
        let firebaseParameters = mapToFirebase(parameters)
        #if DEBUG
        if let param = firebaseParameters {
            print("Firebase Log: Event \(name); Parameters: \(param)")
        } else {
            print("Firebase Log: Event \(name);")
        }
        #endif
        FirebaseAnalytics.Analytics.logEvent(name, parameters: firebaseParameters)
    }

    public static func logFirebaseScreenEvent(_ screen: Analytics.Screen) {
        let param = [Analytics.Parameter.screenName.rawValue: screen.rawValue]
        Analytics.logFirebaseEvent(AnalyticsEventScreenView, parameters: param)
    }

    public static func logFirebaseSwipeEvent(_ value: Analytics.Value) {
        let param = [Analytics.Parameter.action.rawValue: value.rawValue]
        Analytics.logFirebaseEvent(Analytics.Event.swipe.rawValue, parameters: param)
    }

    public static func logFirebaseClickEvent(_ value: Analytics.Value) {
        let param = [Analytics.Parameter.action.rawValue: value.rawValue]
        Analytics.logFirebaseEvent(Analytics.Event.click.rawValue, parameters: param)
    }

    public static func logFirebaseClickEvent(_ value: String) {
        let param = [Analytics.Parameter.action.rawValue: value]
        Analytics.logFirebaseEvent(Analytics.Event.click.rawValue, parameters: param)
    }

    /// Maps the values of the specified dictionary to the valid data types required by Firebase.
    /// Allowed values are String, Int, Float and Double.
    /// If a value could not be mapped, it will be discarded.
    private static func mapToFirebase(_ parameters: [String: Any]?) -> [String: Any]? {
        guard let params = parameters else { return nil }
        return params.compactMapValues { value in
            switch value {
            case is String: return value as? NSString
            case let intValue as Int: return NSNumber(value: intValue)
            case let floatValue as Float: return NSNumber(value: floatValue)
            case let doubleValue as Double: return NSNumber(value: doubleValue)
            default:
                return nil
            }
        }
    }

}

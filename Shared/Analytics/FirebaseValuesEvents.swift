//
//  FirebaseValuesEvents.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 09.01.23.
//

extension Analytics {
    enum Event: String {
        case click
        case swipe
    }

    enum Value: String {
        case startWork = "start_work"
        case endWork = "end_work"
        case startPause = "start_pause"
        case endPause = "end_pause"
        case homeToolbar = "home_toolbar"
        case historyToolbar = "history_toolbar"
        case addDateToolbar = "add_date_toolbar"
        case pausePicker = "pause_picker"
        case datePicker = "date_picker"
        case timeInPicker = "time_in_picker"
        case timeOutPicker = "time_out_picker"
        case closePicker = "close_picker"
        case showMenu = "show_menu"
        case hideMenu = "hide_menu"
        case historySection = "history_section"
        case pauseLiveWork = "pause_live_work"
        case endLiveWork = "end_live_work"
        case addEditSaveButton = "add_edit_save_button"
    }

    enum Parameter: String {
        case screenName = "screen_name"
        case action
    }

    enum Screen: String {
        case homeScreen = "home_screen"
        case history = "history"
        case settings = "settings"
        case settingsTime = "settings_time"
        case settingsLiveWork = "settings_live_work"
        case addDate = "add_date"
        case editDate = "edit_date"
        case addEditSpecialDay = "add_edit_special_day"
    }
}

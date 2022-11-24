//
//  HistoryView2.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 22.11.22.
//

import SwiftUI

class HistoryViewModel: ObservableObject {

    // MARK: Published variables
    @Published var sections: [String] = []
    @Published var sectionType: SectionType

    // MARK: Lifecycle
    init() {
        sectionType = .week
    }

    // MARK: Public functions
    func createSections(dates: [Dates]) {
        sections.removeAll()
        for date in dates {
            let sectionText = "\(sectionType.value(for: date).first)/\(sectionType.value(for: date).second)"
            if !sections.contains(sectionText) {
                sections.append(sectionText)
            }
        }
    }

    func shouldShowDate(date: Dates, for section: String) -> Bool {
        return "\(sectionType.value(for: date).first)/\(sectionType.value(for: date).second)" == section
    }

    func changeSectionType() {
        switch sectionType {
        case .week:
            sectionType = .month
        case .month:
            sectionType = .year
        case .year:
            sectionType = .week
        }
    }
}

// MARK: SectionType
extension HistoryViewModel {
    enum SectionType {
        case week
        case month
        case year

        var component: (first: Calendar.Component, second: Calendar.Component?) {
            switch self {
            case .week:
                return (first: .weekOfYear, second: .yearForWeekOfYear)
            case .month:
                return (first: .month, second: .year)
            case .year:
                return (first: .year, second: nil)
            }
        }

        func value(for date: Dates) -> (first: String, second: String) {
            guard let date = date.date else { return (first: "", second: "") }
            let firstValueFoSection = String(Calendar.current.component(self.component.first, from: date))
            let secondValueFoSection: String
            if let value = self.component.second {
                secondValueFoSection = String(Calendar.current.component(value, from: date))
            } else {
                secondValueFoSection = ""
            }
            return (first: firstValueFoSection, second: secondValueFoSection)
        }
    }
}

struct HistoryView: View {
    @EnvironmentObject var coreDataManager: CoreDataManager
    @StateObject var viewModel: HistoryViewModel = HistoryViewModel()
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(.theme.accent)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(.theme.accent)]
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.sections, id: \.self) { section in
                    Section(header: Text(section)) {
                        ForEach(coreDataManager.dates, id: \.self) { date in
                            if viewModel.shouldShowDate(date: date, for: section) {
                                HistoryListRowView(value: date)
                            }
                        }
                        .onDelete(perform: coreDataManager.removeDate)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Section") {
                        viewModel.changeSectionType()
                        viewModel.createSections(dates: coreDataManager.dates)
                    }
                }
            }
        }
        .accentColor(Color.theme.accent)
        .onAppear {
            viewModel.createSections(dates: coreDataManager.dates)
        }
    }
}

struct HistoryListRowView: View {
    let value: Dates
    var body: some View {
        HStack(spacing: 0) {
            if let timeIn = value.timeIn, let timeOut = value.timeOut, let date = value.date {
                VStack(alignment: .leading) {
                    if value.night {
                        Text("\(date.toString(format: .dayOnlyShort))-" +
                             "\(date.plusOneDay()!.toString(format: .dayOnlyShort))")
                        Text("\(date.toString(format: .dayOnlyNumber))-" +
                             "\(date.plusOneDay()!.toString(format: .shortDate))")
                    } else {
                        Text("\(date.toString(format: .dayOnly))")
                        Text("\(date.toString(format: .shortDate))")
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.28, alignment: .leading)
                Spacer()
                VStack(alignment: .trailing) {
                    HStack {
                        Text("\(timeIn, style: .time)")
                        Image.store.arrowUpLeft
                            .foregroundColor(Color.theme.green)
                    }
                    HStack {
                        Text("\(timeOut, style: .time)")
                        Image.store.arrowUpRight
                            .foregroundColor(Color.theme.red)
                    }
                }
                Spacer()
                HStack {
                    VStack(alignment: .trailing) {
                        Text("\(value.secWork.toTimeString())")
                        if value.specialDay == nil { Text("\(value.secPause.toTimeString())") }
                    }
                    VStack {
                        Image.store.hammer
                        if value.specialDay == nil { Image.store.pauseCircle }
                    }
                    .foregroundColor(Color.theme.gray)
                }
                .frame(width: UIScreen.main.bounds.width * 0.28, alignment: .trailing)
            }
        }
        .font(.headline)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

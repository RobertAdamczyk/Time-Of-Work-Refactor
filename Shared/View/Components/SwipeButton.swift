//
//  SwipeButton.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 28.11.22.
//

import SwiftUI

class SwipeButtonViewModel: ObservableObject {
    enum ButtonType {
        case end
        case start

        var textBefore: some View {
            switch self {
            case .end:
                return Text("End your work")
                        .font(.subheadline)
                        .fontWeight(.bold)
            case .start:
                return Text("Start your work")
                        .font(.subheadline)
                        .fontWeight(.bold)
            }
        }

        var textAfter: some View {
            switch self {
            case .end:
                return Text("Ended")
                        .font(.subheadline)
                        .fontWeight(.bold)
            case .start:
                return Text("Started")
                        .font(.subheadline)
                        .fontWeight(.bold)
            }
        }

        var textDuring: some View {
            switch self {
            case .end:
                return Text("Ending...")
                        .font(.subheadline)
                        .fontWeight(.bold)
            case .start:
                return Text("Starting...")
                        .font(.subheadline)
                        .fontWeight(.bold)
            }
        }
    }

    enum State {
        case idle
        case done
    }
    // MARK: Published properties
    @Published var circleOffset: CGSize = .zero
    @Published var state: State = .idle

    // MARK: Public properties
    let buttonSize: CGSize = CGSize(width: 250, height: 50)
    let diameterCircle: CGFloat = 42
    let strokeWidth: CGFloat = 4
    var endOffset: CGFloat {
        return buttonSize.width - diameterCircle - 2 * strokeWidth
    }

    // MARK: Properties onAppear
    var action: (() -> Void)?
    var type: ButtonType = .start

    // MARK: Public functions
    func onChangedDragGesture(gesture: DragGesture.Value) {
        guard state == .idle else { return }
        switch type {
        case .start: circleOffset = CGSize(width: gesture.translation.width, height: 0)
        case .end: circleOffset = CGSize(width: -gesture.translation.width, height: 0)
        }
        guard circleOffset.width >= 0 else {
            circleOffset.width = 0
            return
        }
        if circleOffset.width >= endOffset {
            circleOffset.width = endOffset
        }
    }

    func onEndedDragGesture(gesture: _ChangedGesture<DragGesture>.Value) {
        guard state == .idle else { return }
        if circleOffset.width >= endOffset {
            simpleHaptic()
            action?()
            state = .done
        } else {
            resetOffset()
        }
    }

    /// This function is implemented, because I don't want long line in view....
    func circleOffsetForView() -> CGSize {
        switch type {
        case .start: return CGSize(width: circleOffset.width, height: 0)
        case .end: return CGSize(width: -circleOffset.width, height: 0)
        }
    }

    func onEnabled() {
        circleOffset = .zero
        state = .idle
    }

    func onDisabled() {
        circleOffset.width = endOffset
        state = .done
    }

    // MARK: Private functions
    private func resetOffset() {
        withAnimation {
            circleOffset = .zero
        }
    }

    private func simpleHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct SwipeButton: View {
    @StateObject var viewModel: SwipeButtonViewModel = SwipeButtonViewModel()
    let type: SwipeButtonViewModel.ButtonType
    let disabled: Bool
    let action: (() -> Void)?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                .stroke(lineWidth: viewModel.strokeWidth)
                .foregroundColor(Color.theme.gray)
                .frame(height: viewModel.buttonSize.height)
            viewModel.type.textBefore
                .opacity( viewModel.circleOffset.width > viewModel.endOffset * 0.5 ? 0 : 1)
            HStack {
                if viewModel.type == .end { Spacer(minLength: 0) }
                RoundedRectangle(cornerSize: CGSize(width: viewModel.diameterCircle * 0.5,
                                                    height: viewModel.diameterCircle * 0.5))
                    .foregroundColor(Color.theme.accent)
                    .frame(height: viewModel.diameterCircle)
                    .frame(width: viewModel.diameterCircle + viewModel.circleOffset.width)
                if viewModel.type == .start { Spacer(minLength: 0) }
            }
            .padding(.horizontal, 4)
            switch viewModel.state {
            case .done: viewModel.type.textAfter
            case .idle: viewModel.type.textDuring
                    .opacity( viewModel.circleOffset.width > viewModel.endOffset * 0.5 ? 1 : 0)
            }
            HStack {
                if viewModel.type == .end { Spacer() }
                Circle()
                    .foregroundColor(Color.theme.accent)
                    .frame(height: viewModel.diameterCircle)
                    .overlay(
                        ZStack {
                            switch viewModel.type {
                            case .start:
                                Image.store.arrowUpRight
                                    .foregroundColor(Color.theme.green)
                            case .end:
                                Image.store.arrowUpLeft
                                    .foregroundColor(Color.theme.red)
                            }
                        }
                    )
                    .offset(viewModel.circleOffsetForView())
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                viewModel.onChangedDragGesture(gesture: gesture)
                            }
                            .onEnded { gesture in
                                viewModel.onEndedDragGesture(gesture: gesture)
                            }
                    )
                if viewModel.type == .start { Spacer() }
            }
            .padding(.horizontal, 4)
        }
        .frame(width: viewModel.buttonSize.width)
        .onAppear {
            if disabled { viewModel.onDisabled() }
            viewModel.action = action
            viewModel.type = type
        }
        .onChange(of: disabled) { newValue in
            if !newValue { viewModel.onEnabled() }
        }
    }
}

struct SwipeButton_Previews: PreviewProvider {
    static var previews: some View {
        SwipeButton(type: .start, disabled: false, action: nil)
    }
}

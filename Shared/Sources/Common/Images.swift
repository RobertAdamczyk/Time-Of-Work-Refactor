//
//  Images.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 18.11.22.
//

import SwiftUI

enum ImageStore: String, CaseIterable {
    case checkmark = "checkmark"
    case person = "person.fill"
    case info = "info"
    case chevronRight = "chevron.right"
    case chevronBackward = "chevron.backward"
    case arrowUpLeft = "arrowshape.turn.up.left.fill"
    case arrowUpRight = "arrowshape.turn.up.right.fill"
    case hammer = "hammer.fill"
    case pauseCircle = "pause.circle"
    case caseFill = "case.fill"
    case flag = "flag.fill"
    case bandage = "bandage.fill"
    case menu = "line.horizontal.3"
    case gearshape = "gearshape.fill"
    case calendar = "calendar"
    case plus = "plus.circle.fill"
    case square2x2 = "square.grid.2x2"
    case sliderHorizontal = "slider.horizontal.3"
    case close = "xmark"
    case envelope = "envelope.fill"

    var image: Image {
        return Image(systemName: self.rawValue)
    }
}

#if DEBUG
private struct ImagesList: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
        ]
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(ImageStore.allCases, id: \.self) { item in
                VStack{
                    HStack {
                        Text(item.rawValue)
                        Spacer()
                        item.image
                            .font(.largeTitle)
                    }
                    Divider()
                }
            }
        }
    }
}

struct ImagesList_Previews: PreviewProvider {
    static var previews: some View {
        ImagesList()
    }
}
#endif

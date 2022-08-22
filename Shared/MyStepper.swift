//
//  MyStepper.swift
//  Stepper
//
//  Created by Chris Eidhof on 17.08.22.
//

import Foundation
import SwiftUI

struct MyStepper<Label: View>: View {
    @Binding var value: Int
    var `in`: ClosedRange<Int> // todo
    @ViewBuilder var label: Label
    
    @Environment(\.controlSize)
    var controlSize
    
    var padding: Double {
        switch controlSize {
        case .mini: return 4
        case .small: return 6
        default: return 8
        }
    }
        
    var body: some View {
        HStack {
            label
            Spacer()
            HStack {
                Button("-") { value -= 1 }
                Text(value.formatted())
                Button("+") { value += 1 }
            }
            .transformEnvironment(\.font, transform: { font in
                if font != nil { return }
                switch controlSize {
                case .mini: font = .footnote
                case .small: font = .callout
                default: font = .body
                }

            })
            .padding(.vertical, padding)
            .padding(.horizontal, padding * 2)
            .foregroundColor(.white)
            .background {
                Capsule()
                    .fill(.tint)
            }
        }
        .buttonStyle(.plain)
    }
}

struct MyStepper_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MyStepper(value: .constant(10), in: 0...100, label: { Text("Value") })
            MyStepper(value: .constant(10), in: 0...100, label: { Text("Value") })
                .controlSize(.mini)
            MyStepper(value: .constant(10), in: 0...100, label: { Text("Value") })
                .controlSize(.large)
                .font(.largeTitle)
        }.padding()
    }
}

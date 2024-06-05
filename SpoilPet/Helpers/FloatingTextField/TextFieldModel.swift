    //
    //  TextFieldModel.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 6/4/24.
    //

    //
    //  Model.swift
    //  FloatingTextField
    //
    //  Created by 변경민 on 2020/12/21.
    //

import SwiftUI

public enum ContentType {
    case none
    case email
    case number
    case phone
    case name
}

public enum FloatingTextFieldStyle {
    case normal
    case square
}

public func checkValidation(_ content: String, type: ContentType) -> Bool{
    switch type {
        case .email: return true
        case .name: return true
        case .none: return true
        case .number: return true
        case .phone: return true
    }
}

public struct Restricts {
    var minLength: Int = Int.min
    var maxLegnth: Int = Int.max

    public init() {

    }
}

    // custom numberkeyboard

struct CustomNumberPad: View {

    @Binding var codes: [String]

    var body: some View  {

        VStack(alignment: .center, spacing: 8) {

            ForEach(datas) { i in

                HStack(spacing: 8) {
                    ForEach(i.row) { j in

                        Button {
                            if j.value == "delete.left" {
                                self.codes.removeLast()
                            } else if j.value == "Space" {
                                self.codes.append("  ")
                            } else if j.value == "Done" {
                                    // add dismiss action
                            } else {
                                self.codes.append(j.value)
                            }

                        } label: {

                            if j.value == "delete.left" {
                                Image(systemName: j.value)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .padding(17)
                                    .padding(.horizontal, 15)
                                    .background(.cell)
                                    .clipShape(.rect(cornerRadius: 20))

                            } else {
                                Text(j.value)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .padding(15)
                                    .padding(.horizontal, 30)
                                    .background(.cell)
                                    .clipShape(.rect(cornerRadius: 20))
                            }
                        }

                    }
                }
            }
        }
        .foregroundStyle(.white)
    }

    func getSpacing() -> CGFloat {
        return UIScreen.main.bounds.width / 3
    }
}

struct Verification: View {

    @State var code: [String] = []

    var body: some View {
        VStack {

            Text("Enter").font(.title)

            HStack(spacing: 8) {
                ForEach(code, id: \.self) { i in
                    Text(i).font(.title).fontWeight(.semibold)
                }
            }

            Spacer()
            CustomNumberPad(codes: $code)
        }
    }
}

struct CustomNumberPad_Previews: PreviewProvider {
    static var previews: some View {
        @State var code: [String] = []
        NavigationStack {
            VStack {

                Spacer()
                Verification(code: code)
            }
        }.preferredColorScheme(.dark)
    }
}

struct type: Identifiable {

    var id: Int
    var row: [row]
}

struct row: Identifiable {

    var id: Int
    var value: String
}

var datas = [

    type(id: 0, row: [row(id: 0, value: "1"), row(id: 1, value: "2"), row(id: 2, value: "3")]),
    type(id: 1, row: [row(id: 0, value: "4"), row(id: 1, value: "5"), row(id: 2, value: "6")]),
    type(id: 2, row: [row(id: 0, value: "7"), row(id: 1, value: "8"), row(id: 2, value: "9")]),
    type(id: 3, row: [row(id: 0, value: "/"), row(id: 1, value: "0"), row(id: 2, value: "delete.left")]),
    type(id: 4, row: [row(id: 0, value: "Space"), row(id: 1, value: "Done")])


]

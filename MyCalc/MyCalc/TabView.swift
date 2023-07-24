//
//  TabView.swift
//  MyCalc
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI
import MCCalculator
import MCSettings
import MCSharedUI
import MCCoordinator

public struct TabViewContainer: View {
    var calculatorCoordinator: CalculatorCoordinator
    var settingsCoordinator: SettingsCoordinator

    public var body: some View {
        TabView {
            calculatorCoordinator.start()
                .tabItem {
                    TabItem(imageName: "function", title: "Calculator")
                }

            settingsCoordinator.start()
                .tabItem {
                    TabItem(imageName: "gearshape", title: "Settings")
                }
        }
        .tint(Color.pink)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewContainer(calculatorCoordinator: CalculatorCoordinator(),
                         settingsCoordinator: SettingsCoordinator())
    }
}

    //
    //  ScheduleView.swift
    //  SpoilPet
    //
    //  Created by Alex Ryan on 5/23/24.
    //

import SwiftUI

struct ScheduleView: View {
    
    @State var currentDate: Date = .init()
    
        // WeekSlider
    @State var weekSlider: [[Date.WeekDay]] = []
    @State var currentWeekIndex: Int = 1
        // Animation Namespace
    @Namespace private var animation
    
    @State private var createWeek: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading) {
                        
                            // Week Slider
                        TabView(selection: $currentWeekIndex,
                                content:  {
                            ForEach(weekSlider.indices, id: \.self) { index in
                                let week = weekSlider[index]
                                
                                weekView(week)
                                    .tag(index)
                                
                            }
                        })
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: 90)
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        Rectangle().fill(.hero.opacity(0.8))
                            .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                            .ignoresSafeArea()
                    }
                    .onChange(of: currentWeekIndex, initial: false) { oldValue, newValue in
                        if newValue == 0 || newValue == (weekSlider.count - 1) {
                            createWeek = true
                        }
                    }
                        //body
                    VStack {
                        WaterPetReminderView()
                        
                        
                    }
                    .padding()
                }
                .vSpacing(.top)
                .frame(maxWidth: .infinity)
                .onAppear() {
                    if weekSlider.isEmpty {
                        let currentWeek = Date().fetchWeek()
                        
                        if let firstDate = currentWeek.first?.date {
                            weekSlider.append(firstDate.createPreviousWeek())
                        }
                        
                        weekSlider.append(currentWeek)
                        
                        if let lastDate = currentWeek.last?.date {
                            weekSlider.append(lastDate.createNextWeek())
                        }
                    }
                }
            }
            .foregroundStyle(.text)
            .navigationTitle("Schedule")
        }
    }
    
        // Week View
    @ViewBuilder
    func weekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack {
                    Text(day.date.firstLetterOfWeekday())
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .text : Color.text)
                    
                    Text(day.date.format("dd"))
                        //.font(.system(size: 20))
                        .frame(width: 50, height: 55)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .text : Color.text)
                    
                }
                .background(content: {
                    if isSameDate(day.date, currentDate) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accent)
                            //.offset(y: 3)
                            .matchedGeometryEffect(id: "TabIndicator", in: animation)
                    }
                    
                    if day.date.isToday {
                        Circle()
                            .fill(.text)
                            .frame(width: 5, height: 5)
                            .vSpacing(.bottom)
                            .offset(y: -8)
                    }
                })
                .hSpacing(.center)
                .onTapGesture {
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
            }
        }
        .background {
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self, perform: { value in
                        if value.rounded() == 15 && createWeek {
                            paginateWeek()
                            createWeek = false
                        }
                    })
            }
        }
    }
    
    func paginateWeek() {
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
}

#Preview {
    ScheduleView()
}

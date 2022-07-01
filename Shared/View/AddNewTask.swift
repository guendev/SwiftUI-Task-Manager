//
//  AddNewTask.swift
//  Task Manager
//
//  Created by Yuan on 01/07/2022.
//

import SwiftUI

struct AddNewTask: View {
    
    @EnvironmentObject var taskModel: TaskViewModel
    
    // Lấy mọi biến môi trường
    @Environment(\.self) var env
    
    // Animation
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Edit Task")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }

                }
            
            FormItem("Task Color") {
                // Sample color
                let colors: [String] = ["Yellow", "Green", "Blue", "Red", "Orange"]

                HStack(spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(Color(color))
                            .frame(width: 25, height: 25)
                            .background {

                                Circle()
                                    .strokeBorder(.gray)
                                    .padding(-3)
                                    .scaleEffect(taskModel.taskColor == color ? 1 : 0.5)

                            }
                            .contentShape(Circle())
                            .onTapGesture {
                                withAnimation {
                                    taskModel.taskColor = color
                                }
                            }
                    }
                }
                .padding(.top, 10)
            }
            .padding(.top, 30)

            Divider()
                .padding(.vertical, 10)
            
            FormItem("Task Deadline") {
                Text(taskModel.taskDeadline.formatted(date: .abbreviated, time: .omitted) + " ," + taskModel.taskDeadline.formatted(date: .omitted, time: .shortened))
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.top, 8)
            }
            .overlay(alignment: .bottomTrailing) {
                Button {

                } label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                }

            }

            Divider()

            VStack(alignment: .leading, spacing: 12) {
                Text("Task Title")
                    .font(.caption)
                    .foregroundColor(.gray)

                TextField("", text: $taskModel.taskTitle)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
            }
            .padding(.top, 10)

            Divider()
            
            FormItem("Task Type") {
                let taskTypes: [String] = ["Basic", "Urgent", "Important"]
                HStack(spacing: 12) {
                    ForEach(taskTypes, id: \.self) { type in
                        Text(type)
                            .font(.callout)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(taskModel.taskType == type ? .white : .black)
                            .background {

                                if taskModel.taskType == type {
                                    Capsule()
                                        .fill(.black)
                                        .matchedGeometryEffect(id: "TYPE", in: animation)
                                } else {

                                    Capsule()
                                        .strokeBorder(.black)

                                }

                            }
                            .contentShape(Capsule())
                            .onTapGesture {
                                withAnimation {
                                    taskModel.taskType = type
                                }
                            }
                    }
                }
            }
            .padding(.vertical, 10)



            Divider()


            // Save Button
            Button {
                if taskModel.addTask(context: env.managedObjectContext)  {
                    env.dismiss()
                }
            } label: {
                Text("Save Task")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .foregroundColor(.white)
                    .background {
                        Capsule()
                            .fill(.black)
                    }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 10)
            .disabled(taskModel.taskTitle == "")
            .opacity(taskModel.taskTitle == "" ? 0.5 : 1)

            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
            .environmentObject(TaskViewModel())
    }
}

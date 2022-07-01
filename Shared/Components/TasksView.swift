//
//  TasksView.swift
//  Task Manager
//
//  Created by Yuan on 02/07/2022.
//

import SwiftUI
import CoreData

struct TasksView: View {
    
    // Fetch Data
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var tasks: FetchedResults<Task>
    
    @Environment(\.self) var env
    
    var body: some View {
        LazyVStack(spacing: 20) {
            
            ForEach(tasks) { task in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        
                        Text(task.type ?? "")
                            .font(.callout)
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background {
                                Capsule()
                                    .fill(.gray.opacity(0.03))
                            }
                        
                        Spacer()
                        
                        if !task.isCompleted {
                            Button {
                                
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.black)
                            }

                        }
                        
                    }
                    
                    Text(task.title ?? "")
                        .font(.title2.bold())
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Label {
                                Text((task.deadline ?? Date())!.formatted(date: .long, time: .omitted))
                            } icon: {
                                Image(systemName: "calendar")
                            }
                            .font(.caption)
                            
                            Label {
                                Text((task.deadline ?? Date())!.formatted(date: .omitted, time: .shortened))
                            } icon: {
                                Image(systemName: "clock")
                            }
                            .font(.caption)
                            

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        
                        if !task.isCompleted {
                            Button {
                                
                                task.isCompleted.toggle()
                                try? env.managedObjectContext.save()
                                
                            } label: {
                                
                                Circle()
                                    .strokeBorder(.black, lineWidth: 1)
                                    .frame(width: 25, height: 25)
                                    .contentShape(Circle())
                                
                                
                            }

                        }
                        
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(task.color ?? "Yellow"))
                }
            }
            
        }
        .padding(.top, 20)
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

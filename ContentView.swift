//
//  ContentView.swift
//  ToDoNotesApp
//
//  Created by Bobby Rojo on 4/21/24.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        HStack {
            RemindersView()
            NotesView()
                
        }
        .environment(\.colorScheme, .light)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.teal)
        
    }
       
    
}

struct Reminder: Identifiable {
    let id = UUID()
    let msg: String
    var checked: Bool = false
}

struct ReminderView: View {
    
    @Binding var reminder: Reminder
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.teal)
                .shadow(radius:1)
            HStack {
                Text(reminder.msg)
                Spacer()
                Image(systemName: reminder.checked ? "checkmark.circle.fill": "checkmark.circle")
            }
            .onTapGesture {
                if reminder.checked == true {
                    reminder.checked = false
                } else {
                    reminder.checked = true
                }
            }
            .padding(.all, 9.0)
        }
        
    }
}

struct RemindersView: View {
    
    @State var showAlert = false
    @State var newReminder = ""
    @State var reminders = [Reminder(msg: "Do Laundry"), Reminder(msg: "Study TOC"), Reminder(msg: "Study EECE")]
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("Reminders").font(.system(size: 24))
                Spacer()
            }.background(.clear)
                .padding()
            

            List($reminders) { $reminder in
                ReminderView(reminder: $reminder)
                    .contextMenu {
                        Button(action: {
                            for i in 0...reminders.count-1 {
                                if reminders[i].msg == reminder.msg {
                                    reminders.remove(at: i)
                                }
                                        
                            }
                        }){
                            Text("Delete")
                        }
                    }
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
            HStack {
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
                    .onTapGesture {
                        showAlert = true
                        newReminder = ""
                    }
                    .alert("Enter reminder message", isPresented: $showAlert) {
                        TextField("", text: $newReminder)
                        Button("Done", action: submit)
                    }
                
            }
            
        }
        
    }
    func submit() {
        reminders.append(Reminder(msg: newReminder))
    }
}
    
    

struct NotesView: View {
    
    @State var notesText: String = "\n\nEnter your notes here..."
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 10)
                Text("Notes").font(.system(size: 24))
                Spacer()
            }.background(.clear)
                .padding()
            
            ZStack {
                TextEditor(text: $notesText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                    
                    
                    
            }
            
                
        }
        
    }
}



#Preview {
    ContentView()
}

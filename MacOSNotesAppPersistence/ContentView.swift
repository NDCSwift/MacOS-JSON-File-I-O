//
// Project: MacOSNotesAppPersistence
//  File: ContentView.swift
//  Created by Noah Carpenter
//  🐱 Follow me on YouTube! 🎥
//  https://www.youtube.com/@NoahDoesCoding97
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
//  Dream Big, Code Bigger


import SwiftUI
import AppKit
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var notes: [Note] = []
    @State private var selectedNote: Note? = nil
    @State private var fileMessage = ""
    
    var fileURL: URL {
        let manager = FileManager.default
        let docs = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent("notes.json")
    }
    
    var body: some View {
        HStack {
            List(selection: $selectedNote) {
                ForEach(notes) { note in
                    Text(note.title).lineLimit(1).tag(note)
                }
                .onDelete(perform: deleteNote)
            }
            .frame(width: 200)
            
            VStack(alignment: .leading, spacing: 10) {
                if let note = selectedNote {
                    TextField("Title", text: binding(for: note).title)
                        .font(.headline)
                    TextEditor(text: binding(for: note).body)
                        .frame(minHeight: 200)
                } else {
                    Text("Select or create a note")
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Button("New Note", action: addNote)
                    Button("Save All", action: saveNotes)
                    Button("Reload", action: loadNotes)
                }
                
                Text(fileMessage)
                    .font(.caption)
                    .foregroundColor(.green)
            }
            .padding()
        }
        .onAppear {
            loadNotes()
        }
    }
}

// MARK: - Helpers and File I/O
extension ContentView {
    func binding(for note: Note) -> Binding<Note> {
        guard let index = notes.firstIndex(where: { $0.id == note.id }) else {
            fatalError("Note not found")
        }
        return $notes[index]
    }
    
    func addNote() {
        let newNote = Note(title: "New Note", body: "")
        notes.append(newNote)
        selectedNote = newNote
    }
    
    func deleteNote(at offsets: IndexSet) {
        // Track which IDs are being deleted so we can update selection after removal
        let deletedIDs: Set<UUID> = Set(offsets.map { notes[$0].id })
        notes.remove(atOffsets: offsets)
        
        // If the selected note was deleted, move selection to the first remaining note
        if let selected = selectedNote, deletedIDs.contains(selected.id) {
            selectedNote = notes.first
        }
        
        saveNotes()
    }
    
    func saveNotes() {
        do {
            let data = try JSONEncoder().encode(notes)
            try data.write(to: fileURL, options: [.atomic])
            fileMessage = "Saved!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                fileMessage = ""
            }
            print("✅ Notes saved at: \(fileURL.path)")
        } catch {
            fileMessage = "Save failed!"
            print("❌ Save error:", error.localizedDescription)
        }
    }
    
    func loadNotes() {
        let manager = FileManager.default
        if manager.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                notes = try JSONDecoder().decode([Note].self, from: data)
                // Restore selection if possible; otherwise pick the first note
                if let selected = selectedNote, notes.contains(selected) {
                    // keep current selection
                } else {
                    selectedNote = notes.first
                }
                print("📂 Loaded \(notes.count) notes.")
            } catch {
                print("❌ Load failed:", error.localizedDescription)
            }
        } else {
            print("ℹ️ No file found yet.")
        }
    }
}

// Preview for Xcode canvas
#Preview {
    ContentView()
}

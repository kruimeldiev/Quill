//
//  Book + Stubs.swift
//  Quill
//
//  Created by Casper Daris on 14/07/2023.
//

import Foundation

extension Book {

    static var stubShort: Book {
        switch Int.random(in: 0...1) {
            case 0:
                return Book(id: UUID().uuidString,
                            creationDate: .randomPastDate(),
                            title: "Sapiens",
                            authors: ["Yuval Noah Harari"],
                            tags: ["History", "Learning"],
                            notes: [.stubMedium])
            default:
                return Book(id: UUID().uuidString,
                            creationDate: .randomPastDate(),
                            title: "De Fundamenten",
                            authors: ["Ramsey Nasr"],
                            tags: ["Society", "Dutch"],
                            notes: [.stubShort, .stubMedium])
        }
    }
    
    static var stubMedium: Book {
        switch Int.random(in: 0...1) {
            case 0:
                return Book(id: UUID().uuidString,
                            creationDate: .randomPastDate(),
                            title: "A Brief History of Time",
                            authors: ["Stephen Hawking", "Albert Einstein"],
                            tags: ["Learning", "Science"],
                            notes: [.stubLong, .stubShort, .stubMedium, .stubLong])
            default:
                return Book(id: UUID().uuidString,
                            creationDate: .randomPastDate(),
                            title: "Het Leven als Tragikomedie",
                            authors: ["Tim Fransen"],
                            tags: ["Dutch", "Comedy", "Philosophy"],
                            notes: [ .stubShort, .stubMedium, .stubLong])
        }
    }

    static var stubLong: Book {
        switch Int.random(in: 0...1) {
            case 0:
                return Book(id: UUID().uuidString,
                            creationDate: .randomPastDate(),
                            title: "Play the piano drunk like a percussion instrument until the fingers begin to bleed a bit",
                            authors: ["Charles Bukowski"],
                            tags: ["Poems"],
                            notes: [.stubLong, .stubShort, .stubMedium, .stubLong, .stubShort])
            default:
                return Book(id: UUID().uuidString,
                            creationDate: .randomPastDate(),
                            title: "The Dawn of Everything: A New History of Humanity",
                            authors: ["David Graeber", "David Wengrow"],
                            tags: ["History"],
                            notes: [.stubLong, .stubShort, .stubMedium, .stubLong, .stubShort])
        }
    }
}

extension BookNote {
    
    static var stubShort: BookNote {
        BookNote(id: UUID().uuidString,
                 title: "Lorem ipsum",
                 note: "Velit sed ullamcorper morbi tincidunt ornare massa. Nam at lectus urna duis convallis convallis tellus id interdum. Velit aliquet sagittis id consectetur.",
                 creationDate: .randomPastDate(),
                 isPrivate: false,
                 tags: ["History", "Learning"])
    }
    
    static var stubMedium: BookNote {
        BookNote(id: UUID().uuidString,
                 title: "Duis aute irure dolor in reprehenderit in voluptate",
                 note: "Nunc congue nisi vitae suscipit tellus. Eget felis eget nunc lobortis. Quis hendrerit dolor magna eget est lorem ipsum. Diam vel quam elementum pulvinar etiam non. Nec ullamcorper sit amet risus. Leo in vitae turpis massa sed elementum tempus. Sollicitudin nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Posuere lorem ipsum dolor sit amet consectetur adipiscing. Ut ornare lectus sit amet est placerat in egestas. Habitant morbi tristique senectus et netus et malesuada fames ac. Nullam non nisi est sit. Euismod lacinia at quis risus sed vulputate odio. Tortor at auctor urna nunc. Arcu dui vivamus arcu felis bibendum ut tristique. Ornare aenean euismod elementum nisi quis eleifend quam. Rhoncus dolor purus non enim praesent elementum. Egestas egestas fringilla phasellus faucibus scelerisque eleifend donec pretium.",
                 creationDate: .randomPastDate(),
                 isPrivate: false,
                 tags: [])
    }
    
    static var stubLong: BookNote {
        BookNote(id: UUID().uuidString,
                 title: "Excepteur sint occaecat cupidatat",
                 note: "Elit eget gravida cum sociis natoque penatibus et. Est ante in nibh mauris cursus mattis molestie. Placerat duis ultricies lacus sed turpis tincidunt. Sodales ut etiam sit amet nisl purus in mollis nunc. Placerat orci nulla pellentesque dignissim enim. Tristique et egestas quis ipsum suspendisse ultrices gravida. Sed faucibus turpis in eu mi. Sit amet mauris commodo quis imperdiet massa tincidunt. Viverra justo nec ultrices dui sapien eget mi proin sed. Sapien et ligula ullamcorper malesuada proin libero nunc. Dignissim convallis aenean et tortor. Ac tortor dignissim convallis aenean et.\n\nGravida rutrum quisque non tellus. Diam volutpat commodo sed egestas egestas fringilla phasellus. Consequat interdum varius sit amet mattis vulputate enim nulla aliquet. Non odio euismod lacinia at quis risus sed vulputate odio. Ut lectus arcu bibendum at varius vel. Dui nunc mattis enim ut tellus elementum sagittis vitae. Sit amet massa vitae tortor condimentum lacinia. Quis ipsum suspendisse ultrices gravida. Pretium viverra suspendisse potenti nullam ac tortor vitae purus. Cras sed felis eget velit aliquet.",
                 creationDate: .randomPastDate(),
                 isPrivate: false,
                 tags: ["Lorem Ipsum", "Comedy"])
    }
}

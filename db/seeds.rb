UserBook.destroy_all
User.destroy_all
Book.destroy_all


User.create(username: "kaia",
        email: "kaia@kaia.com",
        password: "kaia"
        )


10.times do
    User.create(username: Faker::Games::Pokemon.name,
        email: Faker::Internet.email(domain: 'example'),
        password: ENV['SECRETPASSWORD']
    )
end

User.all.each do |user|
    5.times do
        user.user_books.build(condition: "new")
    end
    10.times do
        user.user_books.build(condition: "used")
    end
    2.times do
        user.user_books.build(condition: "ancient")
    end
    user.user_books.each do |book|
        book.book= Book.create(title:Faker::Book.title,
            author: Faker::Book.author,
            publisher: Faker::Book.publisher,
            genre: Faker::Book.genre,
            year: rand(1800..2021)
        )
        book.save
    end
    user.user_books.last.book.rare=true
    user.user_books.last.book.save
end

puts "good to go"
 
    
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create some users with hashed passwords
user1 = User.create(username: 'johndoe', email: 'johndoe@example.com', password_digest: BCrypt::Password.create('password123'))
user2 = User.create(username: 'janedoe', email: 'janedoe@example.com', password_digest: BCrypt::Password.create('password456'))



# Create some books
book1 = user1.books.create(title: 'The Color Purple', img: 'https://i.pinimg.com/564x/eb/95/ef/eb95efe525990fc784a159da12f39007.jpg', bookLink: 'https://www.amazon.com/Color-Purple-Alice-Walker/dp/0156031825', description: 'The Color Purple is a 1982 epistolary novel by American author Alice Walker which won the 1983 Pulitzer Prize for Fiction and the National Book Award for Fiction.', user: user1)
book2 = user2.books.create(title: 'The Bluest Eye', img: 'https://www.pbs.org/wgbh/americanexperience/media/filer_public_thumbnails/filer_public/c5/d8/c5d80c46-10bd-43e2-b017-9bd5e6fa880e/bluesteye-feature.jpg__400x616_q85_crop_subsampling-2_upscale.jpg', bookLink: 'https://www.amazon.com/Bluest-Eye-Vintage-International/dp/0307278441', description: 'The Bluest Eye is Toni Morrison\'s first novel, a book heralded for its richness of language and boldness of vision.', user: user2)


# Create some comments
comment1 = Comment.create(content: 'I loved this book!', book: book1, user: user1)
comment2 = Comment.create(content: 'This book was really inspiring.', book: book2, user: user2)

# Create some ratings
rating1 = Rating.create(value: 4, book: book1)
rating2 = Rating.create(value: 5, book: book2)
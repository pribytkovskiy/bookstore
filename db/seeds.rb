# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
web_development = Category.create!(category: 'Web Development')
web_design = Category.create!(category: 'Web Design')
mobile_development = Category.create!(category: 'Mobile Development')

author1 = Author.create!(first_name: 'Vitaly', last_name: 'Friedman', description: 'Vitaly Friedman description')
author2 = Author.create!(first_name: 'Daniel', last_name: 'Mall', description: 'Daniel Mall description')
author3 = Author.create!(first_name: 'Jon', last_name: 'Duckett', description: 'Jon Duckett description')
author4 = Author.create!(first_name: 'Bass', last_name: 'Jobsen', description: 'Bass Jobsen description')
author5 = Author.create!(first_name: 'David', last_name: 'Cochran', description: 'David Cochran description')
author6 = Author.create!(first_name: 'Ian', last_name: 'Whitley', description: 'Ian Whitley description')
author7 = Author.create!(first_name: 'Kyle', last_name: 'Mew', description: 'Kyle Mew description')
author8 = Author.create!(first_name: 'Sammy', last_name: 'Spets', description: 'Sammy Spets description')
author9 = Author.create!(first_name: 'John', last_name: 'Horton', description: 'John Horton description')
author10 = Author.create!(first_name: 'Helder', last_name: 'Vasconcelos', description: 'Helder Vasconcelos description')
author11 = Author.create!(first_name: 'Raul', last_name: 'Portales', description: 'Raul Portales description')

def add_covers(book)
  4.times { book.covers.create!(image_url: 'https://s3.amazonaws.com/yuriy-book-store/uploads/cover/image/9/41AxHjVqzpL.jpg') }
end

book1 = Product.new(title: 'Real-Life Responsive Web Design10',
                     description: 'The Smashing Book 5: Real-Life Responsive Web Design is Smashing Magazine’s brand new book with smart front-end techniques and design patterns derived from real-life responsive projects. Part 1 features 7 chapters on responsive workflow, SVG, Flexbox, content strategy, and design patterns — just what you need to master all the tricky facets and hurdles of responsive design.',
                     price: 32.90,
                     quantity: 1,
                     year: 2016,
                     dimensions: '6.4 x 0.9 x 5.0',
                     materials: 'Hardcove, glossy paper')
book1.authors << author1
book1.authors << author2
book1.category = web_development
add_covers(book1)
book1.save

book2 = Product.create!(title: 'JavaScript & jQuery: Interactive front-end web development',
                     description: 'This full-color book will show you how to make your websites more interactive and your interfaces more interesting and intuitive. As with our first book (the best-selling HTML & CSS: Design and Build Websites), each chapter: breaks subjects down into bite-sized chunks with a new topic on each page, contains clear descriptions of syntax, each one demonstrated with inspiring code samples, uses diagrams and photography to explain complex concepts in a visual way. By the end of the book, not only will you be able to use the thousands of scripts, JavaScript APIs, and jQuery plugins that are freely available on the web, and be able to customize them - you will also be able to create your own scripts from scratch. If you\'re looking to create more enriching web experiences, then this is the book for you.',
                     price: 23.67,
                     quantity: 1,
                     year: 2016,
                     dimensions: '6.4 x 0.9 x 5.0',
                     materials: 'Paperback, glossy paper')
book2.authors << author3
book2.category << web_development
add_covers(book2)

book3 = Product.create!(title: 'Programming Drupal 7 Entities',
                     description: 'Programming Drupal 7 Entities is perfect for intermediate or advanced developers new to Drupal entity development who are looking to get a good grounding in how to code using the new paradigm. It’s assumed that you will have some experience in PHP development already, and being vaguely familiar with Drupal, GIT, and Drush will also help.',
                     price: 34.99,
                     quantity: 1,
                     year: 2015,
                     dimensions: '6.4 x 0.9 x 5.0',
                     materials: 'Paperback, glossy paper')
book3.authors << author8
book3.categories << web_development
add_covers(book3)

book4 = Product.create!(title: 'Bootstrap 4 Site Blueprints',
                     description: 'The book starts off by getting you up and running with the new features of Bootstrap 4 before gradually moving on to customizing your blog with Bootstrap and SASS, building a portfolio site, and turning it into a WordPress theme. In the process, you will learn to recompile Bootstrap files using SASS, design a user interface, and integrate JavaScript plugins. Towards the end of the book, you will also be introduced to integrating Bootstrap 4 with popular application frameworks such as Angular 2, Ruby on Rails, and React.',
                     price: 49.99,
                     quantity: 1,
                     year: 2016,
                     dimensions: '6.4 x 0.9 x 5.0',
                     materials: 'Paperback, glossy paper')
book4.authors << author4
book4.authors << author5
book4.authors << author6
book4.categories << web_development
add_covers(book4)

book5 = Product.create!(title: 'Learning Material Design',
                     description: 'Google\'s Material Design language has taken the web development and design worlds by storm. Now available on many more platforms than Android, Material Design uses color, light, and movements to not only generate beautiful interfaces, but to provide intuitive navigation for the user. Learning Material Design will teach you the fundamental theories of Material Design using code samples to put these theories into practice. Focusing primarily on Android Studio, you\'ll create mobile interfaces using the most widely used and powerful material components, such as sliding drawers and floating action buttons. Each section will introduce the relevant Java classes and APIs required to implement these components. With the rules regarding structure, layout, iconography, and typography covered, we then move into animation and transition, possibly Material Design\'s most powerful concept, allowing complex hierarchies to be displayed simply and stylishly. With all the basic technologies and concepts mastered, the book concludes by showing you how these skills can be applied to other platforms, in particular web apps, using the powerful Polymer library.',
                     price: 34.99,
                     quantity: 1,
                     year: 2015,
                     dimensions: '6.4 x 0.9 x 5.0',
                     materials: 'Paperback, glossy paper')
book5.authors << author7
book5.categories << web_design
add_covers(book5)

book6 = Product.create!(title: 'Android Programming for Beginners',
                     description: 'Are you trying to start a career in programming, but haven\'t found the right way in? Do you have a great idea for an app, but don\'t know how to make it a reality? Or maybe you\'re just frustrated that "to learn Android, you must know java.” If so, Android Programming for Beginners is for you. You don\'t need any programming experience to follow along with this book, just a computer and a sense of adventure.',
                     price: 49.99,
                     quantity: 1,
                     year: 2015,
                     dimensions: '6.4 x 0.9 x 5.0',
                     materials: 'Paperback, glossy paper')
book6.authors << author9
book6.categories << mobile_development
add_covers(book6)

book7 = Product.create!(title: 'Android: Programming for Developers',
                     description: 'If you are an iOS developer or any other developer/programmer and you want to try your hands on developing applications on the Android platform, this course is for you. No prior programming experience is needed as this course will guide you right from the beginning to the advanced concepts of Android programming.',
                     price: 55.99,
                     quantity: 1,
                     year: 2016,
                     dimensions: '6.4 x 0.9 x 5.0',
                     materials: 'Paperback, glossy paper')
book7.authors << author9
book7.authors << author10
book7.authors << author11
book7.categories << mobile_development
add_covers(book7)

book8 = Product.create!(title: 'Android: Programming for Developers2',
                     description: 'If you are an iOS developer or any other developer/programmer and you want to try your hands on developing applications on the Android platform, this course is for you. No prior programming experience is needed as this course will guide you right from the beginning to the advanced concepts of Android programming.',
                     price: 55.99,
                     quantity: 1,
                     year: 2016,
                     dimensions: '6.4 x 0.9 x 5.0',
                     materials: 'Paperback, glossy paper')
book8.authors << author9
book8.authors << author10
book8.authors << author11
book8.categories << mobile_development
add_covers(book8)

book9 = Product.create!(title: 'Android: Programming for Developers3',
                     description: 'If you are an iOS developer or any other developer/programmer and you want to try your hands on developing applications on the Android platform, this course is for you. No prior programming experience is needed as this course will guide you right from the beginning to the advanced concepts of Android programming.',
                     price: 55.99,
                     quantity: 1,
                     year: 2016,
                     dimensions: '6.4 x 0.9 x 5.0',
                     materials: 'Paperback, glossy paper')
book9.authors << author9
book9.authors << author10
book9.authors << author11
book9.categories << mobile_development
add_covers(book9)

book10 = Product.create!(title: 'Learning Material Design2',
                      description: 'Google\'s Material Design language has taken the web development and design worlds by storm. Now available on many more platforms than Android, Material Design uses color, light, and movements to not only generate beautiful interfaces, but to provide intuitive navigation for the user. Learning Material Design will teach you the fundamental theories of Material Design using code samples to put these theories into practice. Focusing primarily on Android Studio, you\'ll create mobile interfaces using the most widely used and powerful material components, such as sliding drawers and floating action buttons. Each section will introduce the relevant Java classes and APIs required to implement these components. With the rules regarding structure, layout, iconography, and typography covered, we then move into animation and transition, possibly Material Design\'s most powerful concept, allowing complex hierarchies to be displayed simply and stylishly. With all the basic technologies and concepts mastered, the book concludes by showing you how these skills can be applied to other platforms, in particular web apps, using the powerful Polymer library.',
                      price: 34.99,
                      quantity: 1,
                      year: 2015,
                      dimensions: '6.4 x 0.9 x 5.0',
                      materials: 'Paperback, glossy paper')
book10.authors << author7
book10.categories << web_design
add_covers(book10)

book11 = Product.create!(title: 'Learning Material Design3',
                      description: 'Google\'s Material Design language has taken the web development and design worlds by storm. Now available on many more platforms than Android, Material Design uses color, light, and movements to not only generate beautiful interfaces, but to provide intuitive navigation for the user. Learning Material Design will teach you the fundamental theories of Material Design using code samples to put these theories into practice. Focusing primarily on Android Studio, you\'ll create mobile interfaces using the most widely used and powerful material components, such as sliding drawers and floating action buttons. Each section will introduce the relevant Java classes and APIs required to implement these components. With the rules regarding structure, layout, iconography, and typography covered, we then move into animation and transition, possibly Material Design\'s most powerful concept, allowing complex hierarchies to be displayed simply and stylishly. With all the basic technologies and concepts mastered, the book concludes by showing you how these skills can be applied to other platforms, in particular web apps, using the powerful Polymer library.',
                      price: 34.99,
                      quantity: 1,
                      year: 2015,
                      dimensions: '6.4 x 0.9 x 5.0',
                      materials: 'Paperback, glossy paper')
book11.authors << author7
book11.categories << web_design
add_covers(book11)

book12 = Product.create!(title: 'Learning Material Design4',
                      description: 'Google\'s Material Design language has taken the web development and design worlds by storm. Now available on many more platforms than Android, Material Design uses color, light, and movements to not only generate beautiful interfaces, but to provide intuitive navigation for the user. Learning Material Design will teach you the fundamental theories of Material Design using code samples to put these theories into practice. Focusing primarily on Android Studio, you\'ll create mobile interfaces using the most widely used and powerful material components, such as sliding drawers and floating action buttons. Each section will introduce the relevant Java classes and APIs required to implement these components. With the rules regarding structure, layout, iconography, and typography covered, we then move into animation and transition, possibly Material Design\'s most powerful concept, allowing complex hierarchies to be displayed simply and stylishly. With all the basic technologies and concepts mastered, the book concludes by showing you how these skills can be applied to other platforms, in particular web apps, using the powerful Polymer library.',
                      price: 34.99,
                      quantity: 1,
                      year: 2015,
                      dimensions: '6.4 x 0.9 x 5.0',
                      materials: 'Paperback, glossy paper')
book12.authors << author7
book12.categories << web_design
add_covers(book12)

book13 = Product.create!(title: 'Learning Material Design5',
                      description: 'Google\'s Material Design language has taken the web development and design worlds by storm. Now available on many more platforms than Android, Material Design uses color, light, and movements to not only generate beautiful interfaces, but to provide intuitive navigation for the user. Learning Material Design will teach you the fundamental theories of Material Design using code samples to put these theories into practice. Focusing primarily on Android Studio, you\'ll create mobile interfaces using the most widely used and powerful material components, such as sliding drawers and floating action buttons. Each section will introduce the relevant Java classes and APIs required to implement these components. With the rules regarding structure, layout, iconography, and typography covered, we then move into animation and transition, possibly Material Design\'s most powerful concept, allowing complex hierarchies to be displayed simply and stylishly. With all the basic technologies and concepts mastered, the book concludes by showing you how these skills can be applied to other platforms, in particular web apps, using the powerful Polymer library.',
                      price: 34.99,
                      quantity: 1,
                      year: 2015,
                      dimensions: '6.4 x 0.9 x 5.0',
                      materials: 'Paperback, glossy paper')
book13.authors << author7
book13.categories << web_design
add_covers(book13)

Deliveries.create!(method: 'Express Delivery', days: '1', price: 20)
Deliveries.create!(method: 'Regular Delivery', days: '3', price: 10)

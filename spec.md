# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app 
- [X] Use ActiveRecord for storing information in a database
- [X] Include more than one model class (e.g. User, Post, Category)
    Models: Users; Products; Orders; Items; ItemRequirements; ItemCodes
- [X] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    User 
        has many products
    Products 
        has many item requirements 
        has many orders
        belongs to user
    Item Requirements
        belongs to product
        has many item codes
    Orders
        has many items
        belongs to product
    Item
        belongs to order
        has many item codes
    Item Code
        belongs to item
        belongs to item requirement
    
- [X] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
- [X] Include user accounts with unique login attribute (username or email)
    validate presence of email
- [X] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- [X] Ensure that users can't modify content created by other users
- [X] Include user input validations
- [X] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [X] You have a large number of small Git commits
- [X] Your commit messages are meaningful
- [X] You made the changes in a commit that relate to the commit message
- [X] You don't include changes in a commit that aren't related to the commit message
# New York Times Best-Sellers WishList

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app allows a user to browse through multiple lists of New York Times' best-sellers that are updated weekly and monthly. The user can look up all the available lists and add any book from the lists to a wishlist if they are considering buying the book in the future.

### App Evaluation

- **Category:** Entertainment / Education / Reading
- **Mobile:** No current features make the app unique to mobile.
- **Story:** Allows the user to select multiple book lists of best-sellers. Displays list info like last time it was updated, list name, and frequency of update (weekly or monthly). Displays the books in the list ranked, and with information such as title, author, description, amazon link, and book image. And allows user to add the list item (book) to a WishList for future reference. The wishList is interactive and allows a user to remove items (books) from it.
- **Market:** Anyone with an interest in reading can find a place here to come across and find books from a variety of reading topics and genres.
- **Habit:** Users can come back each week and search their favorite lists for new releases as lists are updated weekly and some monthly.
- **Scope:** Features could be added to search best-sellers by author, and also allow users to favorite book lists for quick access rather than having to browse through the entire catalog each time.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* user can log in
* user can sign up and create an account
* user can select a list of best-sellers from a variety of options
* user can see the list details and the list items details
* user can add a list item (book) to a WishList
* user can see/access the WishList
* user can select Wishlist item to display its contents
* user can remove Wishlist items

**Optional Nice-to-have Stories**

* user can search for best-sellers by author
* user can favorite best-sellers lists for quick access in the future

### 2. Screen Archetypes

* Login
   * user can log in
   * user can sign up / register and create an account
* Detail
   * user can select a list of best-sellers from a variety of options
   * user can select Wishlist item to display its contents
   * user can remove Wishlist items
   * user can see/access the WishList
* Stream
   * user can see the list details and the list items details
   * user can add a list item (book) to a WishList


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* List Catalog
* List Details 
* WishList

**Flow Navigation** (Screen to Screen)

* Forced Log-in -> Account creation if no log in is available
* List Catalog -> jumps to List Details upon selecting a list
* WishList -> jumps to WishList item details upon selecting an item

## Wireframes

![wireframes](https://user-images.githubusercontent.com/63036048/140606769-d7ad1240-17e1-42e6-acb3-01773d233d18.png)


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Models

Model: Book

|Property|Type|Description
|---|---|---
|objectId|String|unique id for the wishlist book (default field)
|title|String|string containing book title
|author|String|string containing author of the book
|description|String|string containing short description of the book
|amazon_link|String|string containing the link to Amazon to buy book
|img_link|String|string containing link to image

Model: User

|Property|Type|Description
|objectId|String|unique id for the user (default field)
|username|String|string containing username (unique)
|password|String|string containing the user password

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

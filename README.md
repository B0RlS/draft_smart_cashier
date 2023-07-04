# Smart Checkout

## Description
This program is a simulation of a grocery store checkout. Its main task is to calculate the total price of purchases and apply possible discounts to them if they comply with the discount rules.

## Instalation
Clone the repository.
```
$ git clone https://github.com/B0RlS/smart_checkout.git
```
First make sure you have ruby-3.0.3 installed. If you have it
```
$ bundle install
```
To run unit and integration tests

```sh
rspec
```
Finally, to check compliance with linter

```
rubocop
```

## Usage
```sh
ruby lib/main.rb
```

## Possible improvements
- [ ] Add a DiscountCalculator class to calculate the discount and use it in CalculateOrderTotalPrice to unload the CalculateOrderTotalPrice class.
- [ ] Improve error handling
- [ ] Add shared examples in RSpec

---

## Technical evaluation

### Objectives:

- Evaluation of programming style
- Evaluation of language knowledge
- Evaluation of testing approach

### Technical requirements:

- Use Ruby language (not Ruby on Rails)
- Use TDD (Test-Driven Development) methodology
- Use github as public repository
- Use of DB is not required


## Task Description

You are the lead programmer for a small chain of supermarkets. You are required to make a simple
cashier function that adds products to a cart and displays the total price.

### You have the following test products registered:

| Product |  code Name   | Price  |
| ------- | :----------: | :----: |
| GR1     |  Green tea   | £3.11  |
| SR1     | Strawberries | £5.00  |
| CF1     |    Coffee    | £11.23 |

## Special conditions:

- The CEO is a big fan of buy-one-get-one-free offers and of green tea. He wants us to add a
rule to do this.
- The COO, though, likes low prices and wants people buying strawberries to get a price 
discount for bulk purchases. If you buy 3 or more strawberries, the price should drop to £4.50
- The CTO is a coffee addict. If you buy 3 or more coffees, the price of all coffees should
drop to two thirds of the original price.

Our check-out can scan items in any order, and because the CEO and COO change their minds
often, it needs to be flexible regarding our pricing rules.

The interface to our checkout looks like this (shown in ruby):

```ruby
  co = Checkout.new(pricing_rules)
  co.scan(item)
  co.scan(item)
  price = co.total
```
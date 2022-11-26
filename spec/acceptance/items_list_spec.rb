require 'rails_helper'

feature 'List items', %q{
  In order to find the item in stock
  I need to be able to view list of items
} do
    given(:user) { create(:user
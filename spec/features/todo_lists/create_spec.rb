require 'spec_helper'

describe "Create todo lists" do 
     it "redirects to the todo list index page on success" do
        visit "/todo_lists"
        click_link "New Todo List"
        expect(page).to have_content("New Todo List")

        fill_in "Title", with: "My todo List"
        fill_in "Description", with: "This is a sucess today, Capybara POWERRR"
    	click_button "Create Todo list"
    	expect(page).to have_content("My todo List")
    end

    it "displays error when the todo list has no title" do
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
        click_link "New Todo List"
        expect(page).to have_content("New Todo List")

        fill_in "Title", with: ""
        fill_in "Description", with: "This is a sucess today, Capybara POWERRR"
    	click_button "Create Todo list"
        
        expect(page).to have_content("error")
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
    	expect(page).to_not have_content("This is a sucess today, Capybara POWERRR")
    end

        it "displays error when the todo list has a title with less than 3 characters" do
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
        click_link "New Todo List"
        expect(page).to have_content("New Todo List")

        fill_in "Title", with: "Hi"
        fill_in "Description", with: "This is a sucess today, Capybara POWERRR"
    	click_button "Create Todo list"
        
        expect(page).to have_content("error")
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
    	expect(page).to_not have_content("This is a sucess today, Capybara POWERRR")
    end

            it "displays error when the todo list has no Description" do
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
        click_link "New Todo List"
        expect(page).to have_content("New Todo List")

        fill_in "Title", with: "Grocery list"
        fill_in "Description", with: ""
    	click_button "Create Todo list"
        
        expect(page).to have_content("error")
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
    	expect(page).to_not have_content("Grocery list")
    end

        it "displays error when the todo list has a Description with less than 5 characters" do
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
        click_link "New Todo List"
        expect(page).to have_content("New Todo List")

        fill_in "Title", with: "Grocery list"
        fill_in "Description", with: "Capy"
    	click_button "Create Todo list"
        
        expect(page).to have_content("error")
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
    	expect(page).to_not have_content("This is a sucess today, Capybara POWERRR")
    end
end
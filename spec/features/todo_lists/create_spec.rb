require 'spec_helper'

describe "Create todo lists" do 
    def create_todo_list(options={})
        options[:title] ||= "My todo list"
        options[:description] ||= "This is my todo list."

        visit "/todo_lists"
        click_link "New Todo List"
        expect(page).to have_content("New Todo List")

        fill_in "Title", with: options[:title]
        fill_in "Description", with: options[:description]
        click_button "Create Todo list"
    end


     it "redirects to the todo list index page on success" do
        create_todo_list
    	expect(page).to have_content("This is my todo list.")
    end

    it "displays error when the todo list has no title" do
    	expect(TodoList.count).to eq(0)

        create_todo_list title:""	
        
        expect(page).to have_content("error")
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
    	expect(page).to_not have_content("This is a sucess today, Capybara POWERRR")
    end

        it "displays error when the todo list has a title with less than 3 characters" do
    	expect(TodoList.count).to eq(0)

        create_todo_list title:"hi"
        
        expect(page).to have_content("error")
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
    	expect(page).to_not have_content("This is a sucess today, Capybara POWERRR")
    end

    it "displays error when the todo list has no Description" do
    	expect(TodoList.count).to eq(0)

    	create_todo_list title: "Grocery List", description:""
        expect(page).to have_content("error")
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
    	expect(page).to_not have_content("Grocery list")
    end

        it "displays error when the todo list has a Description with less than 5 characters" do
    	expect(TodoList.count).to eq(0)

        create_todo_list title: "Grocery List", description: "Ola"
        
        expect(page).to have_content("error")
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
    	expect(page).to_not have_content("This is a sucess today, Capybara POWERRR")
    end
end
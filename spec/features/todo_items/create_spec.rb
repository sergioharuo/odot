require 'spec_helper'

describe "Adding todo items | " do 

let!(:todo_lists) {TodoList.create(title: "Grocery list", description: "Groceries")}
	
	def visit_todo_list(list)
			visit "/todo_lists"
			within "#todo_list_#{todo_lists.id}" do
			click_link "List Items"
		end
	end

	it "is sucessful with valid content" do 
		visit_todo_list(todo_lists)
		click_link "New Todo Item"
		fill_in "Content", with: "Milk"
		click_button "Save"
		expect(page).to have_content("Added todo list item.")
		within("ul.todo_items") do
			expect(page).to have_content("Milk")
		end
	end

	it "displays an error with no content" do 
		visit_todo_list(todo_lists)
		click_link "New Todo Item"
		fill_in "Content", with: ""
		click_button "Save"
		within("div.flash") do
			expect(page).to have_content("There was a problem adding that todo list item.")
		end
		expect(page).to have_content("Content can't be blank")
	end

		it "displays an error when content is too short(less than 2 characters)" do 
		visit_todo_list(todo_lists)
		click_link "New Todo Item"
		fill_in "Content", with: "Oi"
		click_button "Save"
		within("div.flash") do
			expect(page).to have_content("There was a problem adding that todo list item.")
		end
		expect(page).to have_content("Content is too short")
	end
end
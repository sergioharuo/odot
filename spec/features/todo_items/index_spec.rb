require 'spec_helper'

describe "viewing todo items | " do 

let!(:todo_lists) {TodoList.create(title: "Grocery list", description: "Groceries")}
	
	def visit_todo_list(list)
			visit "/todo_lists"
			within "#todo_list_#{todo_lists.id}" do
			click_link "List Items"
		end
	end


	it "displays the title of the todo list" do
		visit_todo_list(todo_lists)
		within("h1") do #H1 IS THE H1 TAG ON THE HTML FILE
			expect(page).to have_content(todo_lists.title)
	end
end
	it "displays no items when a todo list is empty" do
		visit_todo_list(todo_lists)
		expect(page.all("ul.todo_items li").size).to eq(0)
	end

	it "displays item content when a todo list has items" do
		todo_lists.todo_items.create(content: "Milk")
		todo_lists.todo_items.create(content: "Eggs")

		visit_todo_list(todo_lists)

		expect(page.all("ul.todo_items li").size).to eq(2)

		within "ul.todo_items" do
			expect(page).to have_content("Milk")
			expect(page).to have_content("Eggs")
		end
	end
end

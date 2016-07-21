class TodoItem < ApplicationRecord
  belongs_to :todo_list

  validates :content, presence: true,
					  length: { minimum: 3 }
end

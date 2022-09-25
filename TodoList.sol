// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TodoList {
    // created struct for custom types
    struct Todo {
        string text;
        bool completed;
    }

    // state variables
    Todo[] private todos;

    function createTodo(string calldata _text) external {
        // to create a todo we need to push it into the array according to provided text
        todos.push(Todo({text: _text, completed: false}));
    }

    function updateTodoText(uint256 _index, string calldata _text) external {
        require(todos.length > _index, "Todo does not exist");

        // Method 1 to update an array element:
        todos[_index].text = _text;

        // Method 2 to update an array element:
        // => Todo storage todo = todos[_index];
        // => todo.text = _text;

        // Method 1 and method 2 is same but when there are multiple update elements method 1 saves gas.
    }

    function toggleTodoCompleted(uint256 _index) external {
        require(todos.length > _index, "Todo does not exist");
        // Toggles the completed value of the todo whose index is provided
        todos[_index].completed = !todos[_index].completed;
    }

    function deleteTodo(uint256 _index) external {
        require(todos.length > _index, "Todo does not exist");
        // Deletes the todo whose index is provided
        delete todos[_index];
    }

    function getTodo(uint256 _index)
        external
        view
        returns (string memory, bool)
    {
        require(todos.length > _index, "Todo does not exist");
        // We declare todo as a memory variable because we are only reading and returning not changing anything.
        // But declaring todo as a storage variable will save gas.
        Todo memory todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function getTodoList() external view returns (Todo[] memory) {
        // Returns the entire todo list
        return todos;
    }

    function deleteTodoList() external {
        // Deletes the entire todo list
        delete todos;
    }
}

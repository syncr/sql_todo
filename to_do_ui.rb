require 'pg'
require './lib/task'
require './lib/list'

DB = PG.connect({:dbname => 'to_do'})

def start
  puts "Welcome to the To Do list!"
  puts "Pick an option"

  puts "n = new list"
  puts "l = list lists"

  menu_option = gets.chomp

  if menu_option == 'n'
    new_list

  elsif menu_option == 'l'
    list_lists
    puts "Pick an option"
    puts "p = pick list"
    puts "m = main menu"

    menu_option = gets.chomp
    if menu_option == 'p'
      pick_list
      puts "Pick an option"
      puts "c = create task"
      puts "s = show tasks"
      puts "d = delete a task"
      puts "m = main menu"
      menu_option = gets.chomp
      if menu_option == 's'
        show_tasks
      elsif menu_option == 'c'
        create_task
      elsif menu_option == 'd'
        delete_task
      elsif menu_option == 'm'
        start
      end
    elsif menu_option == "m"
      start
    end
  end
end

def new_list
  puts "Please provide a name for your list"
  user_input = gets.chomp
  list_entry = List.new(user_input)
  list_entry.save
end

def list_lists
  lists = List.all

  lists.each do |list|
    p "#{list.name}"
  end
end

def pick_list
  puts "type in the name of the list you'd like to view"
  user_input = gets.chomp

  List.find_by_name(user_input)
end

def create_task
  puts "Please provide the task name"
  user_input = gets.chomp
  task_instance = Task.new(user_input, List.current_list)
  task_instance.save
  puts "Your task has been saved."
end

def show_tasks
  current_list = List.current_list
  puts List.find_list_tasks(current_list)

end

def delete_task

end

start

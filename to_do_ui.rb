require 'pg'
require './lib/task'
require './lib/list'

DB = PG.connect({:dbname => 'to_do'})

def start
  system 'clear'
  puts "Welcome to the To Do list!"
  puts "Pick an option"

  puts "n = new list"
  puts "l = list lists"

  menu1
end

def menu1
  menu_option = gets.chomp
  case menu_option
    when 'n'
      new_list
      puts "Ok, your list is created"
      start
    when 'l'
      system 'clear'
      list_lists
      menu2
    when 'x'
      exit
    else "sorry I don't understand that"
    menu1
  end
end


def menu2
  puts "Pick a list option"
  puts "p = pick list"
  puts "d = delete list"
  puts "m = main menu"
  menu_option = gets.chomp
  case menu_option
    when 'p'
      pick_list
      system 'clear'
      menu3
    when 'm'
      start
    when 'd'
      delete_list
    else "sorry I don't understand that"
  end
end

def menu3
  show_tasks
  puts "Pick a task option"
  puts "c = create task"
  puts "t = time to finish by"
  puts "f = finished"
  puts "v = view finished tasks"
  puts "d = delete a task"
  puts "m = main menu"
  menu_option = gets.chomp
  case menu_option
    when 'c'
      create_task
    when 't'
      time_to_finish
    when 'f'
      finished
    when 'v'
      view_finished
    when 'd'
      delete_task
    when 'm'
      start
    else "sorry I don't understand that"
  end

  menu3
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
  puts "Please provide the task you'd like to delete"
  user_input = gets.chomp
  Task.delete(user_input)
  puts "#{user_input} has been deleted"
end

def delete_list
  puts "Please provide the list you'd like to delete"
  user_input = gets.chomp
  List.delete(user_input)
  puts "#{user_input} has been deleted"
  sleep(1)
  start
end

def finished
  puts "Which task have you finished"
  user_input = gets.chomp
  Task.finished(user_input)
  puts "Ok, your task #{user_input} has been marked complete."
end

def view_finished
  puts "Here's all your finished tasks"
  puts Task.finished_list
  puts "\n"
end

def time_to_finish

end

start

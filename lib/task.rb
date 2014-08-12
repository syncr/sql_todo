require 'pg'

class Task
  def initialize(name, list_id)
    @name = name
    @list_id = list_id
    @status = ""
    @due_date = '2014-12-25'
  end

  def name
    @name
  end

  def list_id
    @list_id
  end

  def status
    @status
  end

  def due_date
    @due_date
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      name = result['name']
      list_id = result['list_id'].to_i
      tasks << Task.new(name, list_id)
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (name, list_id, due_date) VALUES ('#{@name}', #{@list_id}, '#{@due_date}');")
  end

  def Task.delete(selected_task)
    DB.exec("DELETE FROM tasks WHERE name = '#{selected_task}';")
  end

  def Task.finished(name)
    DB.exec("UPDATE tasks SET status = 'finished' WHERE name = '#{name}';")
    @status = "finished"
  end

  def Task.finished_list
    finished_list = DB.exec("SELECT * FROM tasks WHERE status = 'finished';")
    tasks = []
    finished_list.each do |finished|
      name = finished['name']
      tasks << name
    end
    tasks
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end

  def finish_date(date)
    DB.exec("UPDATE tasks SET due_date = '#{date}' WHERE name = '#{name}';")
    @due_date = date
  end

end


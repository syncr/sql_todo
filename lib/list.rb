require 'pg'

class List
@@current_list = nil

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def List.current_list
    @@current_list
  end

  def name
    @name
  end

  def id
    @id
  end

  def ==(another_list)
    self.name == another_list.name
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      lists << List.new(name)
    end
    lists
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def List.delete(selected_list)
    current_list_int = current_list.to_i
    DB.exec("DELETE FROM lists WHERE name = '#{selected_list}';")
    DB.exec("DELETE FROM tasks WHERE list_id = '#{current_list_int}';")
  end

  def List.find_by_name(list_name)
    results = DB.exec("SELECT * FROM lists WHERE name = '#{list_name}';")
    users_list = results[0]
    name = users_list['name']
    id = users_list['id'].to_i
    @@current_list = id.to_s
    users_list = List.new(name, id)
  end

  def List.find_list_tasks(current_id)
    results = DB.exec("SELECT * FROM tasks WHERE list_id = '#{current_id}';")
    lists = []
    results.each do |result|
      list_id = result['list_id']
      name = result['name']
      current = Task.new(name, list_id)
      lists << current.name
    end
    lists
  end


end

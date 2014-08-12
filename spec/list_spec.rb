require 'spec_helper'

describe List do
  it 'is initialized with a name' do
    list = List.new('Epicodus stuff')
    expect(list).to be_an_instance_of List
  end

  it 'tells you its name' do
    list = List.new('Epicodus stuff')
    expect(list.name).to eq 'Epicodus stuff'
  end

  it 'is the same list if it has the same name' do
    list1 = List.new('Epicodus stuff')
    list2 = List.new('Epicodus stuff')
    expect(list1).to eq list2
  end

  it 'starts off with no lists' do
    expect(List.all).to eq []
  end

  it "lets you save lists to the database" do
    list = List.new('Epicodus Stuff')
    list.save
    expect(List.all).to eq [list]
  end

  it 'sets its ID when you save it' do
    list = List.new('Epicodus stuff')
    list.save
    expect(list.id).to be_an_instance_of Fixnum
  end

  it 'creates a new unique list from user input' do
    my_list = List.new("My_List")
    my_list.save
    expect(my_list.name).to eq("My_List")
  end

  it "will show all the lists" do
    my_list1 = List.new("My_List")
    my_list2 = List.new("Your_List")
    my_list1.save
    my_list2.save
    expect(List.all[0].name).to eq("My_List")
    expect(List.all[1].name).to eq("Your_List")
  end

  it 'allows the user to select a list' do
    my_list1 = List.new("My_List")
    my_list2 = List.new("Your_List")
    my_list1.save
    my_list2.save
    expect(List.find_by_name("My_List")).to eq my_list1
  end

  it 'shows the tasks for a specific list' do
    task1 = Task.new("SQL", "1")
    task2 = Task.new("Java", "2")
    task3 = Task.new("Ruby", "2")
    task1.save
    task2.save
    task3.save
    expect(List.find_list_tasks("2")).to eq(["Java", "Ruby"])
  end
end

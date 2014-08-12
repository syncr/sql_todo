require 'spec_helper'

describe Task do
  it 'is initialized with a name and a task ID' do
    task = Task.new('learn SQL', 1)
    expect(task).to be_an_instance_of Task
  end

  it 'tells you its name' do
    task = Task.new('learn SQL', 1)
    expect(task.name).to eq 'learn SQL'
  end

  it 'tells you its list ID' do
    task = Task.new("learn SQL", 1)
    expect(task.list_id).to eq 1
  end

  it 'starts with no tasks' do
    expect(Task.all).to eq []
  end

  it "lets you save tasks to the database" do
    task = Task.new('learn SQL', 1)
    task.save
    expect(Task.all).to eq [task]
  end

  it 'is the same task if it has the same name and list ID' do
    task1 = Task.new('learn SQL', 1)
    task2 = Task.new('learn SQL', 1)
    expect(task1).to eq task2
  end

  it 'should update the current finish date' do
    task1 = Task.new('SQL', 1)
    task1.finish_date('2015-01-01')
    expect(task1.due_date).to eq '2015-01-01'
  end
end

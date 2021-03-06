require_relative "test_helper"
require_relative '../app/models/task'

class TaskTest < Minitest::Test

  def setup
    @task = Task.create(name: "Do the thing", due_date: Time.new(2016, 1, 1))
    @user = User.create(email: "bob@email.com")
  end

  def teardown
    @task.destroy
    @user.destroy
  end

  # 1
  def test_task_class_exists
    assert @task
  end

  # 2
  def test_task_has_description
    assert_equal "Do the thing", @task.name
  end

  # 3
  def test_task_initially_has_no_status
    assert_equal nil, @task.completed
  end

  # 4
  def test_task_status_can_be_changed
    @task.completed = true

    assert_equal true, @task.completed
  end

  # 5
  def test_task_has_a_due_date
    assert_equal Time.new(2016, 1, 1), @task.due_date
  end

  # 6
  def test_task_due_date_can_be_changed
    @task.due_date = Time.new(2016, 2, 2)

    assert_equal Time.new(2016, 2, 2), @task.due_date
  end

  # 7
  def test_task_belongs_to_user
    @user.tasks << @task

    assert_equal true, @task.user_id?
  end

  def test_random_task_can_be_selected
    @task_2 = Task.create(name: "Second task", due_date: Time.new(2016, 3, 3))

    @user.tasks << @task
    @user.tasks << @task_2

    random_task = @user.tasks.sample

    assert_equal true, random_task.is_a?(ActiveRecord::Base)
  end

end

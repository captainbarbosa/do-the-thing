require_relative "test_helper"
require_relative '../app/models/user'

class UserTest < Minitest::Test

  def setup
    @user = User.create(email: "bob@email.com")
    @task_1 = Task.create(name: "First task", due_date: Time.new(2016, 2, 2))
    @task_2 = Task.create(name: "Second task", due_date: Time.new(2016, 3, 3))
  end

  def teardown
    @user.destroy
    @task_1.destroy
    @task_2.destroy
  end

  # 1
  def test_user_class_exists
    assert @user
  end

  # 2
  def test_user_must_have_email
    @invalid_user = User.create

    assert_equal false, @invalid_user.valid?
    assert_equal "bob@email.com", @user.email
  end

  # 3
  def test_user_can_have_many_tasks
    @user.tasks << @task_1
    @user.tasks << @task_2

    assert_equal [@task_1, @task_2], @user.tasks
  end

end

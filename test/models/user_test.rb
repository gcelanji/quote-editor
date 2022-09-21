require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "name" do
    assert_equal "Manager", users(:manager).name
  end
end

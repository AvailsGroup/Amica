# frozen_string_literal: true

require 'test_helper'

class FavoriteDecoratorTest < ActiveSupport::TestCase
  def setup
    @favorite = Favorite.new.extend FavoriteDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end

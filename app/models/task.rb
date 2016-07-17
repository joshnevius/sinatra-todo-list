class Task < ActiveRecord::Base
  belongs_to :list

  def self.valid_params?(params)
    return !params[:name].empty?
  end
end
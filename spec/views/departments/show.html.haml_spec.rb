require 'rails_helper'

RSpec.describe "departments/show", type: :view do
  before(:each) do
    @department = assign(:department, Department.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end

require 'spec_helper'

RSpec.describe "sanity" do
  it "builds the site" do
    # This is a basic integration-like check to ensure Jekyll can build locally.
    # It is intentionally simple; expand with focused unit tests for logic later.
    result = system("bundle exec jekyll build >/dev/null 2>&1")
    expect(result).to be_truthy
  end
end

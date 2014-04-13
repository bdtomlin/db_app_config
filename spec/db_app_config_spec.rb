require 'spec_helper'

describe DbAppConfig do
  it "allows a value to be set and returns the value" do
    expect(AppConfig.my_name = 'some name').to eq 'some name'
  end

  it "allows a value to be retrieved" do
    AppConfig.my_name = 'some name'
    expect(AppConfig.my_name).to eq 'some name'
  end

  it "allows multiple settings" do
    AppConfig.my_name = 'some name'
    AppConfig.my_name2 = 'some name2'
    expect(AppConfig.my_name2).to eq 'some name2'
  end

  it "refreshes the cache when settings are added allows multiple settings" do
    AppConfig.my_name = 'some name'
    AppConfig.my_name
    AppConfig.my_name2 = 'some name2'
    expect(AppConfig.my_name2).to eq 'some name2'
  end
end

describe DbAppConfig, ".get_all" do
  it "returns a hash of all settings" do
    AppConfig.my_name = 'some name'
    AppConfig.my_name2 = 'some name2'
    hash = {my_name: 'some name', my_name2: 'some name2'}
    expect(AppConfig.get_all).to eq hash
  end

  it "returns a cached result the second time" do
    AppConfig.my_name = 'some name'
    AppConfig.my_name2 = 'some name2'
    AppConfig.get_all
    AppConfig.stub(:generate_list) {raise 'should be cached'}
    expect(->{AppConfig.get_all}).to_not raise_error
  end

  it "returns the correct values from the cache" do
    AppConfig.my_name = 'some name'
    AppConfig.my_name2 = 'some name2'
    AppConfig.get_all
    hash = {my_name: 'some name', my_name2: 'some name2'}
    expect(AppConfig.get_all).to eq hash
  end
end

require 'spec_helper'

describe Xlgrep do
  it 'should have a version number' do
    Xlgrep::VERSION.should_not be_nil
  end

  it 'should do something useful' do
    Dir.chdir(File.expand_path("..", __FILE__)) do
      r = Xlgrep.invalid_json(Dir.glob("examples/**/*.*"))
      r.should == [
        {file: "examples/json_example.xlsx", sheet: "invalid Object", x: "B", y: 2, data: "{'foo': 1}"    , msg: "757: unexpected token at '{'foo': 1}'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Object", x: "B", y: 3, data: "{\"foo\": 1, }", msg: "757: unexpected token at '{\"foo\": 1, }'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Object", x: "B", y: 4, data: "{\"foo\", 1}"  , msg: "757: unexpected token at '{\"foo\", 1}'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Array" , x: "B", y: 2, data: "['foo', 1]"    , msg: "399: unexpected token at ''foo', 1]'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Array" , x: "B", y: 3, data: "[\"foo\", 1, ]", msg: "399: unexpected token at ']'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Array" , x: "B", y: 4, data: "[\"foo\": 1]"  , msg: "399: unexpected token at ': 1]'"}
      ]
    end
  end
end

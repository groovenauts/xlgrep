# -*- coding: utf-8 -*-
require 'spec_helper'

describe Xlgrep do
  it 'should have a version number' do
    Xlgrep::VERSION.should_not be_nil
  end

  let(:buffer){  Xlgrep::ResultBuffer.new }

  it '.invalid_json' do
    Dir.chdir(File.expand_path("..", __FILE__)) do
      Xlgrep.run([Xlgrep::InvalidJson], Dir.glob("examples/**/*.*"), buffer)
      buffer.result.should == [
        {file: "examples/json_example.xlsx", sheet: "invalid Object", x: "B", y: 2, data: "{'foo': 1}"      , msg: "757: unexpected token at '{'foo': 1}'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Object", x: "B", y: 3, data: "{\"foo\": 1, }"  , msg: "757: unexpected token at '{\"foo\": 1, }'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Object", x: "B", y: 4, data: "{\"foo\", 1}"    , msg: "757: unexpected token at '{\"foo\", 1}'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Object", x: "B", y: 5, data: "\n\n{\"foo\", 1}", msg: "757: unexpected token at '{\"foo\", 1}'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Object", x: "B", y: 6, data: "  {\"foo\", 1}"  , msg: "757: unexpected token at '{\"foo\", 1}'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Object", x: "B", y: 7, data: "{\"foo\", 1}  "  , msg: "757: unexpected token at '{\"foo\", 1}'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Object", x: "B", y: 8, data: "{\"foo\", 1}\n\n", msg: "757: unexpected token at '{\"foo\", 1}'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Array" , x: "B", y: 2, data: "['foo', 1]"      , msg: "399: unexpected token at ''foo', 1]'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Array" , x: "B", y: 3, data: "[\"foo\", 1, ]"  , msg: "399: unexpected token at ']'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Array" , x: "B", y: 4, data: "[\"foo\": 1]"    , msg: "399: unexpected token at ': 1]'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Array" , x: "B", y: 5, data: "\n\n[\"foo\": 1]", msg: "399: unexpected token at ': 1]'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Array" , x: "B", y: 6, data: "  [\"foo\": 1]"  , msg: "399: unexpected token at ': 1]'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Array" , x: "B", y: 7, data: "[\"foo\": 1]  "  , msg: "399: unexpected token at ': 1]'"},
        {file: "examples/json_example.xlsx", sheet: "invalid Array" , x: "B", y: 8, data: "[\"foo\": 1]\n\n", msg: "399: unexpected token at ': 1]'"},
      ]
    end
  end

  it '.regexp' do
    Dir.chdir(File.expand_path("..", __FILE__)) do
      Xlgrep.run([Xlgrep::Regexp.new("[A-Z]")], Dir.glob("examples/**/*.*"), buffer)
      buffer.result.should == [
        {:file=>"examples/json_example.xlsx", :sheet=>"invalid Object", :x=>"A", :y=>1, :msg=>"MATCH", :data=>"OK"},
        {:file=>"examples/json_example.xlsx", :sheet=>"invalid Object", :x=>"B", :y=>1, :msg=>"MATCH", :data=>"NG"},
        {:file=>"examples/json_example.xlsx", :sheet=>"invalid Object", :x=>"C", :y=>2, :msg=>"MATCH", :data=>"JSONでは文字列のリテラルとしてシングルクォーテーションは使えません"},
        {:file=>"examples/json_example.xlsx", :sheet=>"invalid Array" , :x=>"A", :y=>1, :msg=>"MATCH", :data=>"OK"},
        {:file=>"examples/json_example.xlsx", :sheet=>"invalid Array" , :x=>"B", :y=>1, :msg=>"MATCH", :data=>"NG"},
        {:file=>"examples/json_example.xlsx", :sheet=>"invalid Array" , :x=>"C", :y=>2, :msg=>"MATCH", :data=>"JSONでは文字列のリテラルとしてシングルクォーテーションは使えません"},
      ]
    end
  end

end

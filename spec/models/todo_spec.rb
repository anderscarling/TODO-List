# vim: fileencoding=utf-8
require 'spec_helper'

describe Todo do
  describe "assigning note_with_meta" do
    before(:each) do
      @todo = Todo.new
    end

    it "should assign note, dates and tags" do
      @todo.note_with_meta = "Katta glass! #abo@test2#ih@ tomorrow @ today # abo # ih"
      @todo.note.should include("Katta glass! @ test2")
      @todo.available_at.should == Chronic.parse("tomorrow").to_date
      @todo.due_at.should       == Chronic.parse("today")
      @todo.tags.should include('abo', 'ih')
      @todo.tags.size.should == 2
    end

    it "should assign note" do
      @todo.note_with_meta = "Ring kungen, sen ät glass. @ today # abo # ih"
      @todo.note.should include("Ring kungen, sen ät glass.")
    end

    it "should assign included unique tags" do
      @todo.note_with_meta = "Hajhaha! Foo Ko #foo # abo # ih # ih"
      @todo.tags.size.should == 3
      @todo.tags.should include('foo', 'abo', 'ih')
    end

    it "should assign included due_at as parsed by chronic" do
      @todo.note_with_meta = "Hajhaha! Foo Ko @ 2012-01-01 07:00 UTC"
      @todo.due_at.should == Chronic.parse("2012-01-01 07:00 UTC")
    end

    it "should assign included due_at and available_at as parsed by chronic" do
      @todo.note_with_meta = "Hajhaha! Foo Ko @ today @ 2012-01-01 07:00 UTC"
      @todo.available_at.should == Chronic.parse("today").to_date
      @todo.due_at.should       == Chronic.parse("2012-01-01 07:00 UTC")
    end

    it "should assign extra @ attributes to note" do
      @todo.note_with_meta = "Hajhaha! Foo Ko #fo @ foo @ today @ 2012-01-01 07:00 UTC"
      @todo.note.should         == "Hajhaha! Foo Ko @ foo"
      @todo.available_at.should == Chronic.parse("today").to_date
      @todo.due_at.should       == Chronic.parse("2012-01-01 07:00 UTC")
    end

  end
end

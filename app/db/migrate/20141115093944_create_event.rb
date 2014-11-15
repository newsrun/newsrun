# -*- coding: utf-8 -*-
class CreateEvent < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.string :title
      t.string :content
      t.string :timetable
      t.string :picpath
      t.string :place
      t.string :ken
      t.string :city
      t.decimal :longitude
      t.decimal :latitude
    end
    Event.create(title: "event1", content: "event1 content", timetable: "2014-11-15", picpath: "", place: "江ノ島", ken: "神奈川", city: "鎌倉" )
    Event.create(title: "event2", content: "event2 content", timetable: "2014-11-15", picpath: "", place: "江ノ島", ken: "神奈川", city: "鎌倉" )
    
  end
  def down
    drop_table :events
  end
end

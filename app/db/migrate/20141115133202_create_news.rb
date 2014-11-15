class CreateNews < ActiveRecord::Migration
  def up
    create_table :news do |n|
      n.string :Title
      n.string :Body
      n.datetime :ReleaseDate
      n.string :Url
      n.text :PhotoLink
    end
  #  News.create(:Title => 'test', :Body=>'test', :Url => 'user', :ReleaseDate=>nil)

  end
  def down
    drop_table :news
  end
end

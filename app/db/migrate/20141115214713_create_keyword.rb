class CreateKeyword < ActiveRecord::Migration
	def up
    create_table :keywords do |n|
      n.string :place
      n.string :date
      n.string :keyword
      n.belongs_to :news
	end
  #  News.create(:Title => 'test', :Body=>'test', :Url => 'user', :ReleaseDate=>nil)

  end
  def down
    drop_table :news
  end
end

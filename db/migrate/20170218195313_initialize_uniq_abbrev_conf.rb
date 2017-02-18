class InitializeUniqAbbrevConf < ActiveRecord::Migration
  def change
    execute "UPDATE venues SET abbrev = id"
    execute "UPDATE reservations SET confirmation = id"
  end
end

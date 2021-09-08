# frozen_string_literal: true

class EnablePgTrigramExt < ActiveRecord::Migration[6.0]
  def change
    enable_extension :pg_trgm
  end
end
